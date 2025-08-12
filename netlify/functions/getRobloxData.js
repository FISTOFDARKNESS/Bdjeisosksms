const axios = require('axios');
const rateLimit = require('express-rate-limit');

// Configurações
const CONFIG = {
  KEY_EXPIRY_HOURS: 24,
  RATE_LIMIT_WINDOW: 15 * 60 * 1000, // 15 minutos
  RATE_LIMIT_MAX: 100, // Máximo de 100 requisições por IP
  ROBLOX_API_TIMEOUT: 5000 // 5 segundos
};

let cachedKeyData = null;

// Gerador de chaves seguras
function generateSecureKey() {
  const crypto = require('crypto');
  return crypto.randomBytes(16).toString('hex');
}

// Gerenciador de cache de chaves
function getCurrentKeyData() {
  const now = Date.now();
  
  if (!cachedKeyData || cachedKeyData.expires < now) {
    cachedKeyData = {
      key: generateSecureKey(),
      expires: now + CONFIG.KEY_EXPIRY_HOURS * 60 * 60 * 1000,
      generatedAt: now,
      usageCount: 0
    };
  }
  return cachedKeyData;
}

// Limitação de taxa para a API do Roblox
const apiLimiter = rateLimit({
  windowMs: CONFIG.RATE_LIMIT_WINDOW,
  max: CONFIG.RATE_LIMIT_MAX,
  message: 'Too many requests from this IP, please try again later'
});

// Obter dados do usuário com cache e tratamento robusto
async function getRobloxUserData(userId) {
  try {
    const response = await axios.get(`https://users.roblox.com/v1/users/${userId}`, {
      timeout: CONFIG.ROBLOX_API_TIMEOUT,
      headers: {
        'User-Agent': 'KeyVerificationService/1.0'
      }
    });

    if (!response.data || !response.data.id) {
      throw new Error('Invalid Roblox API response');
    }

    return {
      username: response.data.name || 'Unknown',
      displayName: response.data.displayName || response.data.name,
      userId: response.data.id,
      lastUpdated: new Date().toISOString()
    };
  } catch (error) {
    console.error(`Roblox API Error for user ${userId}:`, error.message);
    throw new Error('Failed to fetch Roblox user data');
  }
}

// Validador de entrada
function validateInput(body) {
  if (!body) throw new Error('Missing request body');
  
  const { key, robloxUserId } = body;
  
  if (!key || typeof key !== 'string' || key.length < 10) {
    throw new Error('Invalid key format');
  }
  
  if (robloxUserId && (isNaN(robloxUserId) || robloxUserId <= 0)) {
    throw new Error('Invalid Roblox User ID');
  }
  
  return { key, robloxUserId };
}

// Handler principal
exports.handler = async function(event, context) {
  // Configurações de CORS
  const headers = {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Headers": "Content-Type, Authorization",
    "Access-Control-Allow-Methods": "POST, OPTIONS",
    "Content-Type": "application/json"
  };

  // Handle CORS preflight
  if (event.httpMethod === "OPTIONS") {
    return {
      statusCode: 200,
      headers,
      body: JSON.stringify({ status: 'preflight' })
    };
  }

  try {
    // Verificar método HTTP
    if (event.httpMethod !== 'POST') {
      throw new Error('MethodNotAllowed');
    }

    // Parse e validação do corpo
    const body = JSON.parse(event.body || '{}');
    const { key, robloxUserId } = validateInput(body);

    // Verificação da chave
    const currentKeyData = getCurrentKeyData();
    currentKeyData.usageCount += 1;

    if (key !== currentKeyData.key) {
      throw new Error('InvalidKey');
    }

    // Resposta básica se não tiver UserID
    if (!robloxUserId) {
      return {
        statusCode: 200,
        headers,
        body: JSON.stringify({
          status: 'valid',
          expires: currentKeyData.expires,
          generatedAt: currentKeyData.generatedAt
        })
      };
    }

    // Obter dados do Roblox com tratamento de erro
    const userData = await getRobloxUserData(robloxUserId);

    return {
      statusCode: 200,
      headers,
      body: JSON.stringify({
        status: 'valid',
        user: {
          username: userData.username,
          userId: userData.userId,
          displayName: userData.displayName
        },
        keyInfo: {
          expires: currentKeyData.expires,
          generatedAt: currentKeyData.generatedAt,
          usageCount: currentKeyData.usageCount
        }
      })
    };

  } catch (error) {
    // Tratamento centralizado de erros
    console.error('Handler Error:', error.message);

    const errorMap = {
      'InvalidKey': { code: 403, message: 'Invalid or expired key' },
      'MethodNotAllowed': { code: 405, message: 'Method Not Allowed' },
      'Invalid Roblox User ID': { code: 400, message: 'Invalid Roblox User ID' },
      'Invalid key format': { code: 400, message: 'Invalid key format' }
    };

    const errorInfo = errorMap[error.message] || { code: 500, message: 'Internal Server Error' };

    return {
      statusCode: errorInfo.code,
      headers,
      body: JSON.stringify({
        status: 'error',
        message: errorInfo.message,
        details: errorInfo.code === 500 ? undefined : error.message
      })
    };
  }
};

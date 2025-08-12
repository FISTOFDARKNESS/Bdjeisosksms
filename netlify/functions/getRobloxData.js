const axios = require('axios');
const KEY_EXPIRY_HOURS = 24;
let cachedKeyData = null;

// Função para verificar a chave localmente (repetida do verifyKey.js)
function getCurrentKeyData() {
  const now = Date.now();
  if (!cachedKeyData || cachedKeyData.expires < now) {
    cachedKeyData = {
      key: generateKey(),
      expires: now + KEY_EXPIRY_HOURS * 60 * 60 * 1000,
      generatedAt: now
    };
  }
  return cachedKeyData;
}

// Função para obter dados do usuário do Roblox
async function getRobloxUserData(userId) {
  try {
    const response = await axios.get(`https://users.roblox.com/v1/users/${userId}`);
    return {
      username: response.data.name,
      displayName: response.data.displayName,
      userId: response.data.id
    };
  } catch (error) {
    console.error('Erro ao buscar dados do Roblox:', error);
    return null;
  }
}

exports.handler = async function(event, context) {
  // Configuração CORS
  const headers = {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Headers": "Content-Type",
    "Access-Control-Allow-Methods": "POST, OPTIONS",
    "Content-Type": "application/json"
  };

  // Lidar com pré-voo CORS
  if (event.httpMethod === "OPTIONS") {
    return {
      statusCode: 200,
      headers,
      body: JSON.stringify({ message: "CORS preflight" })
    };
  }

  if (event.httpMethod !== 'POST') {
    return {
      statusCode: 405,
      headers,
      body: JSON.stringify({ error: 'Method Not Allowed' })
    };
  }

  let body;
  try {
    body = JSON.parse(event.body);
  } catch {
    return {
      statusCode: 400,
      headers,
      body: JSON.stringify({ error: 'Invalid JSON' })
    };
  }

  const { key, robloxUserId } = body;
  if (!key) {
    return {
      statusCode: 400,
      headers,
      body: JSON.stringify({ error: 'Missing key field' })
    };
  }

  // Verificar a chave primeiro
  const currentKeyData = getCurrentKeyData();
  if (key !== currentKeyData.key) {
    return {
      statusCode: 403,
      headers,
      body: JSON.stringify({ error: 'Invalid or expired key' })
    };
  }

  // Se não foi fornecido um userId, retornar apenas a validade da chave
  if (!robloxUserId) {
    return {
      statusCode: 200,
      headers,
      body: JSON.stringify({
        valid: true,
        expires: currentKeyData.expires,
        generatedAt: currentKeyData.generatedAt
      })
    };
  }

  // Obter dados do Roblox
  try {
    const userData = await getRobloxUserData(robloxUserId);
    
    if (!userData) {
      return {
        statusCode: 404,
        headers,
        body: JSON.stringify({ error: 'Roblox user not found' })
      };
    }

    return {
      statusCode: 200,
      headers,
      body: JSON.stringify({
        valid: true,
        username: userData.username,
        userId: userData.userId,
        expires: currentKeyData.expires,
        generatedAt: currentKeyData.generatedAt
      })
    };
  } catch (error) {
    return {
      statusCode: 500,
      headers,
      body: JSON.stringify({ error: 'Failed to fetch Roblox data' })
    };
  }
};

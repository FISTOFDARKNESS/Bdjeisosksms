const KEY_EXPIRY_HOURS = 24;
let cachedKeyData = null;

function generateKey() {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  let key = '';
  for (let i = 0; i < 20; i++) {
    key += chars.charAt(Math.floor(Math.random() * chars.length));
  }
  return key;
}

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

exports.handler = async function(event, context) {
  // Configuração CORS para permitir requisições do Roblox
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

  const { key } = body;
  if (!key) {
    return {
      statusCode: 400,
      headers,
      body: JSON.stringify({ error: 'Missing key field' })
    };
  }

  const currentKeyData = getCurrentKeyData();
  const isValid = key === currentKeyData.key;

  return {
    statusCode: 200,
    headers,
    body: JSON.stringify({ 
      valid: isValid,
      expires: currentKeyData.expires,
      generatedAt: currentKeyData.generatedAt
    })
  };
};

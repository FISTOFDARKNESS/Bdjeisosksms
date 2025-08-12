let cachedKeyData = null;

function generateKey() {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  let key = '';
  for (let i = 0; i < 20; i++) {
    key += chars.charAt(Math.floor(Math.random() * chars.length));
  }
  return key;
}

function getCurrentKey() {
  const now = Date.now();
  if (!cachedKeyData || cachedKeyData.expires < now) {
    cachedKeyData = {
      key: generateKey(),
      expires: now + 24 * 60 * 60 * 1000
    };
  }
  return cachedKeyData.key;
}

exports.handler = async function(event, context) {
  if (event.httpMethod !== 'POST') {
    return {
      statusCode: 405,
      body: JSON.stringify({ error: 'Method Not Allowed' })
    };
  }

  let body;
  try {
    body = JSON.parse(event.body);
  } catch {
    return {
      statusCode: 400,
      body: JSON.stringify({ error: 'Invalid JSON' })
    };
  }

  const { key } = body;

  if (!key) {
    return {
      statusCode: 400,
      body: JSON.stringify({ error: 'Missing key field' })
    };
  }

  const currentKey = getCurrentKey();

  return {
    statusCode: 200,
    body: JSON.stringify({ valid: key === currentKey })
  };
};

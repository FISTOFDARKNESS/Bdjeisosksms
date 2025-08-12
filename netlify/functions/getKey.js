const KEY_EXPIRY_HOURS = 24;

function generateKey() {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  let key = '';
  for (let i = 0; i < 20; i++) {
    key += chars.charAt(Math.floor(Math.random() * chars.length));
  }
  return key;
}

let cachedKeyData = null;

exports.handler = async function(event, context) {
  const now = Date.now();

  if (!cachedKeyData || cachedKeyData.expires < now) {
    cachedKeyData = {
      key: generateKey(),
      expires: now + KEY_EXPIRY_HOURS * 60 * 60 * 1000,
      generatedAt: now
    };
  }

  return {
    statusCode: 200,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json"
    },
    body: JSON.stringify({ 
      key: cachedKeyData.key,
      expires: cachedKeyData.expires,
      generatedAt: cachedKeyData.generatedAt
    })
  };
};

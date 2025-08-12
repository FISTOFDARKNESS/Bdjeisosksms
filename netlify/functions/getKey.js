let cachedKeyData = null;

function generateKey() {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  let key = '';
  for (let i = 0; i < 20; i++) {
    key += chars.charAt(Math.floor(Math.random() * chars.length));
  }
  return key;
}

exports.handler = async function(event, context) {
  const now = Date.now();

  if (!cachedKeyData || cachedKeyData.expires < now) {
    cachedKeyData = {
      key: generateKey(),
      expires: now + 24 * 60 * 60 * 1000
    };
  }

  return {
    statusCode: 200,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json"
    },
    body: JSON.stringify({ key: cachedKeyData.key })
  };
};

const fs = require('fs');
const path = require('path');

const keyFile = path.join(__dirname, 'currentKey.json');

function generateKey() {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  let key = '';
  for (let i = 0; i < 20; i++) {
    key += chars.charAt(Math.floor(Math.random() * chars.length));
  }
  return key;
}

exports.handler = async (event, context) => {
  let data;
  let regenerate = false;

  try {
    if (fs.existsSync(keyFile)) {
      data = JSON.parse(fs.readFileSync(keyFile, 'utf8'));
      if (Date.now() > data.expires) regenerate = true;
    } else {
      regenerate = true;
    }
  } catch (error) {
    regenerate = true;
  }

  if (regenerate) {
    data = {
      key: generateKey(),
      expires: Date.now() + 24 * 60 * 60 * 1000
    };
    fs.writeFileSync(keyFile, JSON.stringify(data));
  }

  return {
    statusCode: 200,
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ key: data.key })
  };
};

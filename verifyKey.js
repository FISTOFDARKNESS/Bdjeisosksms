const fs = require('fs');
const path = require('path');

const keyFile = path.join('/tmp', 'currentKey.json');

exports.handler = async (event) => {
  const { key } = JSON.parse(event.body || '{}');

  if (!key) {
    return { statusCode: 400, body: JSON.stringify({ valid: false, message: "Key missing" }) };
  }

  if (!fs.existsSync(keyFile)) {
    return { statusCode: 400, body: JSON.stringify({ valid: false, message: "Key not generated yet" }) };
  }

  const data = JSON.parse(fs.readFileSync(keyFile, 'utf8'));

  if (Date.now() > data.expires) {
    return { statusCode: 400, body: JSON.stringify({ valid: false, message: "Key expired" }) };
  }

  if (data.key === key) {
    return { statusCode: 200, body: JSON.stringify({ valid: true }) };
  } else {
    return { statusCode: 400, body: JSON.stringify({ valid: false, message: "Invalid key" }) };
  }
};
const express = require('express');
const fs = require('fs');
const path = require('path');
const app = express();
const port = 3000;

const keyFile = path.join(__dirname, 'currentKey.json');

function generateKey() {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  let key = '';
  for (let i = 0; i < 20; i++) {
    key += chars.charAt(Math.floor(Math.random() * chars.length));
  }
  return key;
}

app.use(express.static('public')); // Serve arquivos estáticos (html, js, css) da pasta 'public'

app.get('/getKey', (req, res) => {
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
      expires: Date.now() + 24 * 60 * 60 * 1000 // expira em 24h
    };
    fs.writeFileSync(keyFile, JSON.stringify(data));
  }

  res.json({ key: data.key });
});

app.listen(port, () => {
  console.log(`Servidor rodando em http://localhost:${port}`);
});

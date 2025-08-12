const express = require('express');
const cors = require('cors');
const app = express();

app.use(cors());
app.use(express.json());

let activeKeys = {}; // chave: dados da key

// Rota para salvar uma nova key
app.post('/api/keys', (req, res) => {
  const { key, shortUrl, pasteUrl, createdAt } = req.body;
  if (!key || !shortUrl || !pasteUrl || !createdAt) {
    return res.status(400).json({ error: 'Dados incompletos' });
  }

  activeKeys[key] = { shortUrl, pasteUrl, createdAt };
  return res.status(200).json({ message: 'Key salva com sucesso' });
});

// Rota para listar todas keys
app.get('/api/keys', (req, res) => {
  return res.json(activeKeys);
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`API rodando na porta ${PORT}`));

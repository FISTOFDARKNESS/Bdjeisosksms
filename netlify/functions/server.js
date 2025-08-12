const express = require('express');
const functions = require('./netlify/functions/getRobloxData'); // Importa sua função
const app = express();

// Middleware para parsear JSON
app.use(express.json());

// Rota principal
app.get('/', (req, res) => {
  res.send('Servidor de verificação de chaves está online!');
});

// Rota que usa sua função getRobloxData
app.post('/verify-roblox', async (req, res) => {
  try {
    // Cria um mock do 'event' que sua função Netlify espera
    const event = {
      body: JSON.stringify(req.body),
      httpMethod: 'POST'
    };
    
    // Chama sua função existente
    const result = await functions.handler(event);
    
    // Retorna o resultado
    res.status(result.statusCode).json(JSON.parse(result.body));
  } catch (error) {
    console.error('Erro:', error);
    res.status(500).json({ error: 'Erro interno no servidor' });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});

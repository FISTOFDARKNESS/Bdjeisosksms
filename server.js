const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const bcrypt = require('bcrypt');
const fs = require('fs');

const app = express();
const PORT = 3000;

app.use(cors());
app.use(bodyParser.json());

const USERS_FILE = './users.json';

function loadUsers() {
  if (!fs.existsSync(USERS_FILE)) return {};
  return JSON.parse(fs.readFileSync(USERS_FILE));
}

function saveUsers(users) {
  fs.writeFileSync(USERS_FILE, JSON.stringify(users, null, 2));
}

app.post('/register', async (req, res) => {
  const { username, password } = req.body;
  const users = loadUsers();

  if (users[username]) {
    return res.status(400).json({ message: 'Utente già registrato' });
  }

  const hashed = await bcrypt.hash(password, 10);
  users[username] = hashed;
  saveUsers(users);
  res.json({ message: 'Registrazione completata' });
});

app.post('/login', async (req, res) => {
  const { username, password } = req.body;
  const users = loadUsers();

  if (!users[username]) {
    return res.status(400).json({ message: 'Credenziali non valide' });
  }

  const isValid = await bcrypt.compare(password, users[username]);
  if (!isValid) {
    return res.status(400).json({ message: 'Credenziali non valide' });
  }

  res.json({ message: 'Login effettuato con successo' });
});

app.listen(PORT, () => {
  console.log(`✅ Server attivo su http://localhost:${PORT}`);
});

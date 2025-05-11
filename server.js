const express = require("express");
const bodyParser = require("body-parser");
const fs = require("fs");
const path = require("path");

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(bodyParser.json());
app.use(express.static(path.join(__dirname, "public")));  // For serving static files like auth.html

// Load users from the 'users.json' file
const loadUsers = () => {
  try {
    const data = fs.readFileSync("users.json", "utf-8");
    return JSON.parse(data);
  } catch (err) {
    return {};
  }
};

// Save users to the 'users.json' file
const saveUsers = (users) => {
  fs.writeFileSync("users.json", JSON.stringify(users, null, 2));
};

// Serve the auth page (auth.html)
app.get("/auth.html", (req, res) => {
  res.sendFile(path.join(__dirname, "public", "auth.html"));
});

// Login Route
app.post("/api/login", (req, res) => {
  const { username, password } = req.body;
  const users = loadUsers();

  if (users[username] && users[username] === password) {
    return res.json({ success: true, message: "Login successful!" });
  } else {
    return res.json({ success: false, message: "Invalid username or password." });
  }
});

// Register Route
app.post("/api/register", (req, res) => {
  const { username, password } = req.body;
  const users = loadUsers();

  if (users[username]) {
    return res.json({ success: false, message: "Username already exists." });
  }

  users[username] = password;
  saveUsers(users);

  return res.json({ success: true, message: "Registration successful!" });
});

// Start the server
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});

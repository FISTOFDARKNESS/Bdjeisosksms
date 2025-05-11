// Import required modules
const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");
const bcrypt = require("bcrypt");
const fs = require("fs");

// Initialize the app
const app = express();
const port = 3000; // Can be any port number

// Middleware
app.use(cors());
app.use(bodyParser.json());

// In-memory user storage (can be replaced with a database)
let users = {};

// Load users from file on server startup (for persistence)
if (fs.existsSync("users.json")) {
  const data = fs.readFileSync("users.json", "utf-8");
  users = JSON.parse(data);
}

// Webhook URL (replace with your own webhook URL)
const webhookURL = "https://discord.com/api/webhooks/1369288755101438012/9SuVCrsgaQUFWbt-T4b8_aKT2cdGlOJC31I2Qfxn8_d0frluUBhXsm16izL5B9-InJIC";

// Utility function to send webhook messages
const sendWebhook = async (content) => {
  try {
    await fetch(https://excaliburstudio.netlify.app/auth.html/webhookURL, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ content }),
    });
  } catch (error) {
    console.warn("Failed to send webhook:", error);
  }
};

// Route to handle login and registration requests
app.post("/webhook", (req, res) => {
  const { content } = req.body;

  if (content) {
    sendWebhook(content);
    res.status(200).send({ message: "Webhook sent" });
  } else {
    res.status(400).send({ error: "Content missing" });
  }
});

// Route to handle user login and registration
app.post("/auth", async (req, res) => {
  const { username, password, isLogin } = req.body;

  // Check if the user exists and process accordingly
  if (isLogin) {
    // Login process
    if (users[username]) {
      const isValidPassword = await bcrypt.compare(password, users[username]);
      if (isValidPassword) {
        sendWebhook(`✅ ${username} logged in at ${new Date().toLocaleString()}`);
        return res.status(200).send({ message: "Login successful" });
      } else {
        return res.status(400).send({ error: "Invalid password" });
      }
    } else {
      return res.status(400).send({ error: "User does not exist" });
    }
  } else {
    // Registration process
    if (users[username]) {
      return res.status(400).send({ error: "Username already exists" });
    } else {
      const hashedPassword = await bcrypt.hash(password, 10);
      users[username] = hashedPassword;

      // Save users to a file (this can be a database in production)
      fs.writeFileSync("users.json", JSON.stringify(users));

      sendWebhook(`🆕 ${username} registered at ${new Date().toLocaleString()}`);
      return res.status(200).send({ message: "Registration successful" });
    }
  }
});

// Start the server
app.listen(port, () => {
  console.log(`Server is running on ${port}`);
});

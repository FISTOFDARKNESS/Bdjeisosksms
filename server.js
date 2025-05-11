const express = require("express");
const bodyParser = require("body-parser");
const fetch = require("node-fetch"); // npm install node-fetch
const path = require("path");

const app = express();
const PORT = 3000;

// Coloque seu webhook do Discord aqui
const WEBHOOK_URL = "https://discord.com/api/webhooks/1369288755101438012/9SuVCrsgaQUFWbt-T4b8_aKT2cdGlOJC31I2Qfxn8_d0frluUBhXsm16izL5B9-InJIC";

// Middleware para parsear JSON
app.use(bodyParser.json());

// Serve arquivos estáticos diretamente da raiz
app.use(express.static(__dirname));

app.post("/webhook", async (req, res) => {
  const { content } = req.body;

  if (!content) return res.status(400).json({ message: "Missing content." });

  try {
    const response = await fetch(WEBHOOK_URL, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ content })
    });

    if (!response.ok) throw new Error("Failed to send webhook");

    res.status(200).json({ message: "Webhook sent successfully" });
  } catch (err) {
    console.error("Webhook error:", err);
    res.status(500).json({ message: "Error sending webhook" });
  }
});

app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});

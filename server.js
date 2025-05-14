const axios = require('axios');

// Função para enviar mensagem via Webhook
async function sendRandomMessage(webhookURL) {
  const names = [
    "Ethan", "Lucas", "Mateo", "Liam", "Noah", "Kai", "Haruki", "Aiden", "Enzo", "Julian",
    "Theo", "Davi", "Elijah", "Tomás", "Hiroshi", "Alex", "Gabriel", "Samuel", "Riku", "Nathan",
    "Mia", "Sofia", "Aiko", "Ava", "Hana", "Chloe", "Isabella", "Yuna", "Naomi", "Laura",
    "Emily", "Luna", "Sakura", "Julia", "Aria", "Mei", "Clara", "Natsuki", "Ellie", "Mila",
    "Ren", "Kira", "Yuri", "Akemi", "Leo", "Rui", "Nico", "Ayaka", "Kenji", "Ayame"
  ];

  const files = [
    "Mahito Domain Expansion",
    "Toji Domain Breaker",
    "Sae flow",
    "Advanced module tween",
    "Moon Animator V4",
    "Animator Spoofer v3",
    "Module Lighting",
    "NNTYJ",
    "Malevolent Shrine"
  ];

  const randomName = names[Math.floor(Math.random() * names.length)];
  const randomFile = files[Math.floor(Math.random() * files.length)];

  const content = `**${randomName}** downloaded the file **${randomFile}**`;

  try {
    await axios.post(webhookURL, { content });
    console.log(`Sent: ${content}`);
  } catch (error) {
    console.error('Error sending message:', error.message);
  }
}

// Função para iniciar o envio contínuo de mensagens com intervalo aleatório
async function startSendingMessages(webhookURL) {
  while (true) {
    await sendRandomMessage(webhookURL);
    const delay = Math.floor(Math.random() * 10000) + 5000; // 5s to 15s
    await new Promise(resolve => setTimeout(resolve, delay));
  }
}

module.exports = startSendingMessages;
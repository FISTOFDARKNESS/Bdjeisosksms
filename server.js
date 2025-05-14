const { Client, GatewayIntentBits } = require('discord.js');
const client = new Client({ intents: [GatewayIntentBits.Guilds, GatewayIntentBits.GuildMessages] });

const TOKEN = 'SEU_TOKEN_AQUI';
const CHANNEL_ID = 'ID_DO_CANAL_AQUI';

const usernames = [
  'Ethan', 'Lucas', 'Mateo', 'Liam', 'Noah', 'Kai', 'Haruki', 'Aiden', 'Enzo', 'Julian',
  'Theo', 'Davi', 'Elijah', 'Tomás', 'Hiroshi', 'Alex', 'Gabriel', 'Samuel', 'Riku', 'Nathan',
  'Mia', 'Sofia', 'Aiko', 'Ava', 'Hana', 'Chloe', 'Isabella', 'Yuna', 'Naomi', 'Laura',
  'Emily', 'Luna', 'Sakura', 'Julia', 'Aria', 'Mei', 'Clara', 'Natsuki', 'Ellie', 'Mila',
  'Ren', 'Kira', 'Yuri', 'Akemi', 'Leo', 'Rui', 'Nico', 'Ayaka', 'Kenji', 'Ayame'
];

const downloads = [
  'Mahito Domain Expansion',
  'Toji Domain Breaker',
  'Sae flow',
  'Advanced module tween',
  'Moon Animator V4',
  'Animator Spoofer v3',
  'Module Lighting',
  'NNTYJ',
  'Malevolent Shrine'
];

function getRandomItem(arr) {
  return arr[Math.floor(Math.random() * arr.length)];
}

async function startSpam(channel) {
  while (true) {
    const username = getRandomItem(usernames);
    const file = getRandomItem(downloads);
    await channel.send(`${username} downloaded the file **${file}**`);

    // Cooldown aleatório entre 5 e 15 segundos
    const cooldown = Math.floor(Math.random() * 10000) + 5000;
    await new Promise(resolve => setTimeout(resolve, cooldown));
  }
}

client.once('ready', () => {
  console.log(`Bot logado como ${client.user.tag}`);
  const channel = client.channels.cache.get(CHANNEL_ID);
  if (!channel) {
    console.error('Canal não encontrado.');
    return;
  }

  startSpam(channel);
});

client.login(TOKEN);
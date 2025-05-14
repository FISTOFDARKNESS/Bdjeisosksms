const webhookURL = 'https://discord.com/api/webhooks/1372113907845697619/Rh0ypDg7WC76enZV72lrEhTN_kXPBKTObmHv9ISNmu-pFwPVfEt6Qll7tUbv5QETCHW4';

    const names = [
  "Ethan Johnson", "Lucas Silva", "Mateo Costa", "Liam Nguyen", "Noah Smith",
  "Kai Tanaka", "Haruki Yamamoto", "Aiden Oliveira", "Enzo Rossi", "Julian Torres",
  "Theo Kim", "Davi Lima", "Elijah Park", "Tomás López", "Hiroshi Nakamura",
  "Alex Garcia", "Gabriel Müller", "Samuel Schneider", "Riku Sato", "Nathan Dubois",
  "Mia Fernández", "Sofia Romano", "Aiko Kobayashi", "Ava Thomas", "Hana Lee",
  "Chloe Gonzalez", "Isabella Sousa", "Yuna Suzuki", "Naomi Moreira", "Laura Becker",
  "Emily Meier", "Luna Martins", "Sakura Ishikawa", "Julia Müller", "Aria Müller",
  "Mei Arai", "Clara Vidal", "Natsuki Takahashi", "Ellie Pereira", "Mila Schneider",
  "Ren Yamazaki", "Kira Freitas", "Yuri Ortega", "Akemi Fujiwara", "Leo Pereira",
  "Rui Martins", "Nico Almeida", "Ayaka Taniguchi", "Kenji Watanabe", "Ayame Honda",
  "Olivia Müller", "Emma Weber", "Charlotte Souza", "Amelia Kato", "Harper Silva",
  "Evelyn Rios", "Abigail Castro", "Ella Schmitt", "Scarlett Oliveira", "Grace Fischer",
  "Aurora Yamane", "Zoey Becker", "Penelope Müller", "Layla Morita", "Hazel Cruz",
  "Nora Pereira", "Riley Yamato", "Victoria Santos", "Brooklyn Takashi", "Eliana Goto",
  "Isla Matsumoto", "Lily Rocha", "Stella Sakamoto", "Hannah Ferrari", "Violet Romano",
  "Archer Tanaka", "Jasper Martins", "Finn Almeida", "Elias Oliveira", "Caleb Wagner",
  "Levi Cardoso", "Daniel Müller", "James Nunes", "Benjamin Matsuda", "Mason Costa",
  "Logan Hoshino", "Owen Castro", "Sebastian Duarte", "Wyatt Meyer", "Ezra Ferreira",
  "Alice Kimura", "Ivy Morimoto", "Camila Souza", "Maya Schuster", "Ariana Dias",
  "Eliza Schulz", "Sarah Nakamoto", "Eva Carvalho", "Cora Kojima", "Madeline Batista",
  "Jonathan Varela", "Felix Okada", "Adam Mendes", "Oscar Abe", "Aaron Fukumoto",
  "Axel Hamada", "Tobias Vieira", "Jayden Yamada", "Adrian Rocha", "Miles Sugimoto",
  "Diego Iwasaki", "Antonio Takeda", "Emilio Mizuno", "Pablo Endo", "Andrés Kudo",
  "Joaquín Tavares", "Raul Shimizu", "Esteban Nakajima", "Bruno Saito", "César Tamura",
  "Giulia Romano", "Alessia Uchida", "Martina Martins", "Beatrice Hirano", "Chiara Carvalho",
  "Elena Sasaki", "Giorgia Aoki", "Bianca Takagi", "Aurora Nogueira", "Francesca Fujita",
  "Matteo Okamoto", "Lorenzo Morita", "Andrea Kaneko", "Riccardo Nakamura", "Davide Suzuki",
  "Tommaso Yamashita", "Niccolò Kubo", "Gabriele Carvalho", "Edoardo Tanigawa", "Giovanni Fukuda",
  "Takashi Morimoto", "Renan Yagi", "Julio Fujimoto", "Igor Kobayashi", "Vinícius Oda",
  "Letícia Hasegawa", "Bruna Komatsu", "Carolina Matsui", "Mariana Inoue", "Larissa Ishii",
  "Sabrina Koga", "Tatiane Tsukamoto", "Fernanda Uchida", "Ana Miyazaki", "Camila Fuji",
  "Thais Aihara", "Isabel Tanaka", "Helena Itō", "Nicole Morishita", "Bianca Nakano",
  "Valentina Higa", "Luiza Arakaki", "Melissa Hirata", "Gabriela Shiraishi", "Natalia Kinoshita",
  "Rebeca Murakami", "Yasmin Oikawa", "Juliana Yoshida", "Viviane Kanazawa", "Aline Kuwabara",
  "Daniela Tsuchiya", "Milena Ogawa", "Patrícia Nomura", "Tatiana Kikuchi", "Cláudia Sugawara",
  "Júlia Tani", "Paula Yamaguchi", "André Kuniyoshi", "Maurício Maeda", "Eduardo Nishimura",
  "Rodrigo Takemoto", "Marcelo Shibata", "Bruno Arima", "Fábio Kamada", "Fernando Aoyama",
  "Gustavo Hoshino", "Felipe Tanoue", "Carlos Sugiura", "Vitor Tashiro", "Rafael Kamiyama",
  "Pedro Yano", "João Kitagawa", "Arthur Matsunaga", "Caio Hosono", "Henrique Koike",
  "Luciano Funaki", "Tiago Hori", "Renato Nozaki", "Sérgio Yamagata", "Márcio Kagami",
  "Eduarda Nakahara", "Amanda Shinoda", "Renata Hara", "Mirella Nagasawa", "Vivian Taniguchi",
  "Cíntia Iwata", "Débora Ogino", "Priscila Tsutsui", "Elisa Furuya", "Marina Miyamoto",
  "Cristina Yanagisawa", "Silvia Araki", "Simone Maekawa", "Patrícia Fujinaga", "Juliane Oshima",
  "Kaori Tanaka", "Mika Yamada", "Yui Suzuki", "Haruka Nakamura", "Rin Kobayashi",
  "Nanami Kato", "Saki Watanabe", "Chihiro Ueda", "Nana Hoshino", "Ami Sato",
  "Reina Fukuda", "Aya Matsumura", "Erika Takahashi", "Asami Arai", "Hitomi Shibata",
  "Misaki Kaneko", "Momo Nakajima", "Yuka Hashimoto", "Sayaka Yamamoto", "Kanon Ishikawa",
  "Hina Tsubaki", "Ayumi Ogawa", "Kaho Tanimoto", "Manami Nishida", "Kokoro Okada",
  "Hinata Sakurai", "Mei Shimada", "Noa Fujimoto", "Emi Kinoshita", "Satomi Morishita",
  "Shiori Kawai", "Miu Taniguchi", "Natsumi Sugiyama", "Saori Tokunaga", "Yuri Aizawa"
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

    async function sendRandomWebhook() {
      const name = names[Math.floor(Math.random() * names.length)];
      const file = files[Math.floor(Math.random() * files.length)];
      const content = `**${name}** downloaded the file **${file}**`;

      try {
        await fetch(webhookURL, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({ content: content })
        });
        console.log('Sent:', content);
      } catch (err) {
        console.error('Erro ao enviar:', err);
      }
    }

    async function startAutoWebhook() {
      while (true) {
        await sendRandomWebhook();
        const delay = Math.floor(Math.random() * 10000) + 5000; // 5s a 15s
        await new Promise(resolve => setTimeout(resolve, delay));
      }
    }

    // Inicia automaticamente quando a página é carregada
    window.onload = () => {
      startAutoWebhook();
    };

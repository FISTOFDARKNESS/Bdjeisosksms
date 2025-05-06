let baseDomain = "https://streamingcommunity.exposed/watch/";



// Film list
const films = [
  // Action
  {
    id: "10002",
    title: "Thunderbolts",
    category: "Action, Adventure",
    year: "2025",
    image: "icons/td.png"
  },
  {
    id: "12141",
    title: "Sinners",
    category: "Action, Adventure",
    year: "2025",
    image: "icons/sn.png"
  },
  {
    id: "2151",
    title: "Flipped",
    category: "Romance",
    year: "2010",
    image: "icons/flipped.png"
  },
  {
    id: "12203",
    title: "Until Dawn",
    category: "Mystery, Horror",
    year: "2025",
    image: "icons/TDT.png"
  },
  {
    id: "6",
    title: "John Wick",
    category: "Action",
    year: "2023",
    image: "icons/john.png"
  },
  {
    id: "626",
    title: "Gladiator",
    category: "Action",
    year: "2000",
    image: "icons/gladiator.png"
  },
  {
    id: "10258",
    title: "Terrifier the beginning",
    category: "Horror",
    year: "2013",
    image: "icons/beginning.png"
  },
  {
    id: "4395",
    title: "Terrifier",
    category: "Horror",
    year: "2016",
    image: "icons/te.png"
  },
  {
    id: "6115",
    title: "Terrifier 2",
    category: "Horro",
    year: "2023",
    image: "icons/te2.png"
  },
   {
    id: "10162",
    title: "Terrifier 3",
    category: "Horror",
    year: "2024",
    image: "icons/te3.png"
  },
   {
    id: "2923",
    title: "Hansel & Gretel - Witchers Hunter",
    category: "action, horror",
    year: "2013",
    image: "icons/wi.png"
  },

  // Sci-Fi
  {
    id: "112",
    title: "Interstellar",
    category: "Sci-Fi",
    year: "2023",
    image: "icons/Interstellar.png"
  },
  {
    id: "1994",
    title: "The Matrix",
    category: "Sci-Fi",
    year: "1999",
    image: "icons/matrix.png"
  },
  {
    id: "1028",
    title: "Blade Runner 2049",
    category: "Sci-Fi",
    year: "2017",
    image: "icons/blade.png"
  },
  // Thriller
  {
    id: "733",
    title: "Inception",
    category: "Thriller",
    year: "2020",
    image: "icons/inception.png"
  },
  {
    id: "904",
    title: "Shutter Island",
    category: "Thriller",
    year: "2010",
    image: "icons/shutter.png"
  },
  {
    id: "252",
    title: "Venom",
    category: "action",
    year: "201i",
    image: "icons/Venom.png"
  },

  // Drama
  {
    id: "2436",
    title: "The Shawshank Redemption",
    category: "Drama",
    year: "1994",
    image: "icons/shaw.png"
  },
  {
    id: "2248",
    title: "Forrest Gump",
    category: "Drama",
    year: "1994",
    image: "icons/gump.png"
  },
  {
    id: "617",
    title: "The Green Mile",
    category: "Drama",
    year: "1999",
    image: "icons/green.png"
  },

  // Horror
  {
    id: "2509",
    title: "The Conjuring",
    category: "Horror",
    year: "2013",
    image: "icons/conjuring.png"
  },
    {
    id: "1570",
    title: "The Conjuring 2",
    category: "Horror",
    year: "2013",
    image: "icons/conjuring2.png"
  },
  {
    id: "846",
    title: "Hereditary",
    category: "Horror",
    year: "2018",
    image: "icons/Hereditary.png"
  },
  {
    id: "2826",
    title: "Sinister",
    category: "Horror",
    year: "2012",
    image: "icons/Sinister.png"
  },
   {
    id: "6340",
    title: "Sinister 2",
    category: "Horror",
    year: "2015",
    image: "icons/Sinister2.png"
  },

  // Comedy
  {
    id: "3042",
    title: "The Grand Budapest Hotel",
    category: "Comedy",
    year: "2014",
    image: "icons/budapest.png"
  },
  {
    id: "6813",
    title: "Five Nights At Diddy'S",
    category: "Comedy/horro/Meme",
    year: "2099",
    image: "icons/diddy.png"
  },
  {
    id: "8511",
    title: "Superbad",
    category: "Comedy",
    year: "2007",
    image: "icons/superbad.png"
  },
  {
    id: "867",
    title: "The Hangover 1",
    category: "Comedy",
    year: "2009",
    image: "icons/Hangover1.png"
  },

  // Animation
  {
    id: "391",
    title: "Spider-Man: Into the Spider-Verse",
    category: "Animation",
    year: "2018",
    image: "icons/into.png"
  },
  {
    id: "871",
    title: "Toy Story 4",
    category: "Animation",
    year: "2019",
    image: "icons/Toy4.png"
  },
  {
    id: "530",
    title: "Coco",
    category: "Animation",
    year: "2017",
    image: "icons/coco.png"
  },
 {
    id: "9897",
    title: "Minecraft Movie",
    category: "Fantasy, Adventure",
    year: "2025",
    image: "icons/mine.png"
  },
   {
    id: "5856",
    title: "Smile",
    category: "Horror",
    year: "2022",
    image: "icons/smile.png"
  },
   {
    id: "10271",
    title: "Smile 2",
    category: "Horror",
    year: "2024",
    image: "icons/smile2.png"
  },
   {
    id: "530",
    title: "Coco",
    category: "Animation",
    year: "2017",
    image: "icons/coco.png"
  },
  // Fantasy
  {
    id: "270",
    title: "Harry Potter and the Sorcerer's Stone",
    category: "Fantasy",
    year: "2001",
    image: "icons/harry1.png"
  },
  {
    id: "2282",
    title: "The Lord of the Rings: The Fellowship of the Ring",
    category: "Fantasy",
    year: "2001",
    image: "icons/lotr1.png"
  },
  {
    id: "2280",
    title: "The Hobbit: An Unexpected Journey",
    category: "Fantasy",
    year: "2012",
    image: "icons/hobbit1.png"
  },
    {
    id: "2518",
    title: "Avatar 2",
    category: "Action",
    year: "2024",
    image: "icons/avatar2.png"
  },
   {
    id: "8856",
    title: "Nymphomaniac",
    category: "18+",
    year: "2013",
    image: "icons/Nymphomaniac.png"
  },
    {
    id: "9963",
    title: "Nymphomaniac 2",
    category: "18+",
    year: "2013",
    image: "icons/Nymphomaniac2.png"
  },
    {
    id: "1520",
    title: "Love",
    category: "18+",
    year: "2015",
    image: "icons/Love.png"
  },
    {
    id: "4960",
    title: "365 Days",
    category: "18+",
    year: "2022",
    image: "icons/365.png"
  },
];

// Load dark mode if saved
if (localStorage.getItem("dark") === "true") {
  document.body.classList.add("dark");
}

// Dark mode toggle
document.getElementById("darkToggle").addEventListener("click", () => {
  document.body.classList.toggle("dark");
  localStorage.setItem("dark", document.body.classList.contains("dark"));
});

// Render films
function renderFilms(list) {
  const container = document.getElementById("film-category");
  container.innerHTML = "";
  list.forEach(film => {
    const el = document.createElement("div");
    el.className = "film";
    el.innerHTML = `
     <img src="${film.image}" alt="${film.title}">
      <h3>${film.title}</h3>
      <p>${film.category} / ${film.year}</p>
      <button class="play-button" data-id="${film.id}">Play</button>
    `;
    container.appendChild(el);
  });

  // Protege as imagens
  protegerImagens();

  document.querySelectorAll(".play-button").forEach(btn => {
    btn.addEventListener("click", () => {
      const id = btn.dataset.id;
      window.location.href = `${baseDomain}${id}`;
    });
  });
}

// Protege as imagens de clicarem e arrastá-las
function protegerImagens() {
  const imagens = document.querySelectorAll('#film-category img');
  imagens.forEach(img => {
    img.setAttribute('oncontextmenu', 'return false');
    img.setAttribute('draggable', 'false');
    img.style.pointerEvents = 'none';
  });
}

// Initial load
renderFilms(films);
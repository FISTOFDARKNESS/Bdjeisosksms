let baseDomain = "https://streamingcommunity.education/watch/";


// Film list
const films = [
  // Action
  {
    id: "10002",
    title: "Thunderbolts",
    category: "Action, Adventure",
    year: "2025",
    image: "icons/td.png",
    canSee: true
  },
  {
    id: "12141",
    title: "Sinners",
    category: "Action, Adventure",
    year: "2025",
    image: "icons/sn.png",
    canSee: true
  },
  {
    id: "2151",
    title: "Flipped",
    category: "Romance",
    year: "2010",
    image: "icons/flipped.png",
    canSee: true
  },
  {
    id: "12203",
    title: "Until Dawn",
    category: "Mystery, Horror",
    year: "2025",
    image: "icons/TDT.png",
    canSee: true
  },
  {
    id: "6",
    title: "John Wick",
    category: "Action",
    year: "2023",
    image: "icons/john.png",
    canSee: true
  },
  {
    id: "626",
    title: "Gladiator",
    category: "Action",
    year: "2000",
    image: "icons/gladiator.png",
    canSee: true
  },
  {
    id: "10258",
    title: "Terrifier the beginning",
    category: "Horror",
    year: "2013",
    image: "icons/beginning.png",
    canSee: true
  },
  {
    id: "4395",
    title: "Terrifier",
    category: "Horror",
    year: "2016",
    image: "icons/te.png",
    canSee: true
  },
  {
    id: "6115",
    title: "Terrifier 2",
    category: "Horro",
    year: "2023",
    image: "icons/te2.png",
    canSee: true    
  },
   {
    id: "10162",
    title: "Terrifier 3",
    category: "Horror",
    year: "2024",
    image: "icons/te3.png",
    canSee: true
  },
   {
    id: "2923",
    title: "Hansel & Gretel - Witchers Hunter",
    category: "action, horror",
    year: "2013",
    image: "icons/wi.png",
    canSee: true
  },

  // Sci-Fi
  {
    id: "112",
    title: "Interstellar",
    category: "Sci-Fi",
    year: "2023",
    image: "icons/Interstellar.png",
    canSee: true
  },
  {
    id: "1994",
    title: "The Matrix",
    category: "Sci-Fi",
    year: "1999",
    image: "icons/matrix.png",
    canSee: true
  },
  {
    id: "1028",
    title: "Blade Runner 2049",
    category: "Sci-Fi",
    year: "2017",
    image: "icons/blade.png",
    canSee: true
  },
  // Thriller
  {
    id: "733",
    title: "Inception",
    category: "Thriller",
    year: "2020",
    image: "icons/inception.png",
    canSee: true
  },
  {
    id: "904",
    title: "Shutter Island",
    category: "Thriller",
    year: "2010",
    image: "icons/shutter.png",
    canSee: true
  },
  {
    id: "252",
    title: "Venom",
    category: "action",
    year: "2018",
    image: "icons/Venom.png",
    canSee: true
  },

  // Drama
  {
    id: "2436",
    title: "The Shawshank Redemption",
    category: "Drama",
    year: "1994",
    image: "icons/shaw.png",
    canSee: true
  },
  {
    id: "2248",
    title: "Forrest Gump",
    category: "Drama",
    year: "1994",
    image: "icons/gump.png",
    canSee: true
  },
  {
    id: "617",
    title: "The Green Mile",
    category: "Drama",
    year: "1999",
    image: "icons/green.png",
    canSee: true
  },

  // Horror
  {
    id: "2509",
    title: "The Conjuring",
    category: "Horror",
    year: "2013",
    image: "icons/conjuring.png",
    canSee: true
  },
    {
    id: "1570",
    title: "The Conjuring 2",
    category: "Horror",
    year: "2013",
    image: "icons/conjuring2.png",
    canSee: true
  },
  {
    id: "846",
    title: "Hereditary",
    category: "Horror",
    year: "2018",
    image: "icons/Hereditary.png",
    canSee: true
  },
  {
    id: "2826",
    title: "Sinister",
    category: "Horror",
    year: "2012",
    image: "icons/Sinister.png",
    canSee: true
  },
   {
    id: "6340",
    title: "Sinister 2",
    category: "Horror",
    year: "2015",
    image: "icons/Sinister2.png",
    canSee: true
  },

  // Comedy
  {
    id: "3042",
    title: "The Grand Budapest Hotel",
    category: "Comedy",
    year: "2014",
    image: "icons/budapest.png",
    canSee: true
  },
  {
    id: "6813",
    title: "Five Nights At Diddy'S",
    category: "Comedy/horro/Meme",
    year: "2099",
    image: "icons/diddy.png",
    canSee: true
  },
  {
    id: "8511",
    title: "Superbad",
    category: "Comedy",
    year: "2007",
    image: "icons/superbad.png",
    canSee: true
  },
  {
    id: "867",
    title: "The Hangover 1",
    category: "Comedy",
    year: "2009",
    image: "icons/Hangover1.png",
    canSee: true
  },

  // Animation
  {
    id: "391",
    title: "Spider-Man: Into the Spider-Verse",
    category: "Animation",
    year: "2018",
    image: "icons/into.png",
    canSee: true
  },
  {
    id: "871",
    title: "Toy Story 4",
    category: "Animation",
    year: "2019",
    image: "icons/Toy4.png",
    canSee: true
  },
 {
    id: "9897",
    title: "Minecraft Movie",
    category: "Fantasy, Adventure",
    year: "2025",
    image: "icons/mine.png",
    canSee: true
  },
   {
    id: "5856",
    title: "Smile",
    category: "Horror",
    year: "2022",
    image: "icons/smile.png",
    canSee: true
  },
   {
    id: "10271",
    title: "Smile 2",
    category: "Horror",
    year: "2024",
    image: "icons/smile2.png",
    canSee: true
  },
   {
    id: "530",
    title: "Coco",
    category: "Animation",
    year: "2017",
    image: "icons/coco.png",
    canSee: true
  },
  // Fantasy
  {
    id: "270",
    title: "Harry Potter and the Sorcerer's Stone",
    category: "Fantasy, Adventure, Family",
    year: "2001",
    image: "icons/harry1.png",
    canSee: true
  },
  {
    id: "2282",
    title: "The Lord of the Rings: The Fellowship of the Ring",
    category: "Fantasy",
    year: "2001",
    image: "icons/lotr1.png",
    canSee: true
  },
  {
    id: "2280",
    title: "The Hobbit: An Unexpected Journey",
    category: "Fantasy",
    year: "2012",
    image: "icons/hobbit1.png",
    canSee: true
  },
    {
    id: "2518",
    title: "Avatar 2",
    category: "Action",
    year: "2024",
    image: "icons/avatar2.png",
    canSee: true
  },
   {
    id: "8856",
    title: "Nymphomaniac",
    category: "18+",
    year: "2013",
    image: "icons/Nymphomaniac.png",
    canSee: true
  },
    {
    id: "9963",
    title: "Nymphomaniac 2",
    category: "18+",
    year: "2013",
    image: "icons/Nymphomaniac2.png",
    canSee: true
  },
    {
    id: "1520",
    title: "Love",
    category: "18+",
    year: "2015",
    image: "icons/Love.png",
    canSee: true
  },
    {
    id: "4960",
    title: "365 Days",
    category: "18+",
    year: "2022",
    image: "icons/365.png",
    canSee: true
  },
    {
    id: "12235",
    title: "Untold: Shooting Guards",
    category: "Documentary",
    year: "2025",
    image: "icons/untold.png",
    canSee: true
  },
    {
    id: "404",
    title: "Harry Potter and the Chamber of Secrets",
    category: "Fantasy, Adventure, Mystery",
    year: "2002",
    image: "icons/harry2.png",
    canSee: true
  },  
      {
    id: "276",
    title: "Harry Potter and the Prisoner of Azkaban",
    category: "Fantasy, Adventure, Mystery",
    year: "2004",
    image: "icons/harry3.png",
    canSee: true
  },
      {
    id: "275",
    title: "Harry Potter and the Goblet of Fire",
    category: "Fantasy, Adventure, Mystery",
    year: "2005",
    image: "icons/harry4.png",
    canSee: true
  },
      {
    id: "277",
    title: "Harry Potter and the Order of the Phoenix",
    category: "Fantasy, Adventure, Action",
    year: "2007",
    image: "icons/harry5.png",
    canSee: true
  },
      {
    id: "274",
    title: "Harry Potter and the Half-Blood Prince",
    category: "Fantasy, Adventure, Drama",
    year: "2009",
    image: "icons/harry6.png",
    canSee: true
  },
      {
    id: "272",
    title: "Harry Potter and the Deathly Hallows: Part 1",
    category: "Fantasy, Adventure, Drama",
    year: "2010",
    image: "icons/harry7.png",
    canSee: true
  },
      {
    id: "271",
    title: "Harry Potter and the Deathly Hallows: Part 2",
    category: "Fantasy, Adventure, Action",
    year: "2011",
    image: "icons/harry8.png",
    canSee: true
  },
      {
    id: "",
    title: "Spider-Man",
    category: "",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
    {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },  
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
    {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },  
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
    {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },  
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
    {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },  
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  }, 
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
    {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },  
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
    {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },  
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
  },
      {
    id: "",
    title: "Comming",
    category: "N/A",
    year: "--",
    image: "icons/.png",
    canSee: false
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

// Renderiza os filmes na tela
function renderFilms(list) {
  const container = document.getElementById("film-category");
  container.innerHTML = "";

  list.forEach(film => {
    if (film.canSee === false) return; // Oculta se não for visível

    const el = document.createElement("div");
    el.className = "film";
    el.innerHTML = `
      <img src="${film.image}" alt="${film.title}" onerror="this.src='icons/error.png'">
      <h3>${film.title}</h3>
      <p>${film.category} / ${film.year}</p>
      <button class="play-button" data-id="${film.id}">Play</button>
    `;
    container.appendChild(el);
  });

  protegerImagens();
}

// Impede o clique e arrasto nas imagens
function protegerImagens() {
  const imagens = document.querySelectorAll('#film-category img');
  imagens.forEach(img => {
    img.setAttribute('oncontextmenu', 'return false');
    img.setAttribute('draggable', 'false');
    img.style.pointerEvents = 'none';
  });
}

// Evento de logout
document.getElementById("logout").addEventListener("click", () => {
  localStorage.removeItem("loggedInUser");
  window.location.href = "auth.html";
});

// Sistema de busca com botão
document.getElementById("search-button").addEventListener("click", () => {
  const query = document.getElementById("search-bar").value.toLowerCase();
  const results = films.filter(film =>
    film.title.toLowerCase().includes(query)
  );
  renderFilms(results);
});

// Sistema de busca com Enter
document.getElementById("search-bar").addEventListener("keydown", (e) => {
  if (e.key === "Enter") {
    document.getElementById("search-button").click();
  }
});

// Delegação de evento para botões de "Play"
document.getElementById("film-category").addEventListener("click", (e) => {
  if (e.target.classList.contains("play-button")) {
    const id = e.target.dataset.id;
    window.location.href = `${baseDomain}${id}`;
  }
});
// Desativa o menu de contexto
document.addEventListener("contextmenu", (e) => e.preventDefault());

// Impede seleção de texto
document.addEventListener("selectstart", (e) => e.preventDefault());

// Impede clique longo no mobile
document.addEventListener("touchstart", (e) => {
  if (e.target.tagName !== "INPUT" && e.target.tagName !== "TEXTAREA") {
    let longPressTimer = setTimeout(() => e.preventDefault(), 500);
    const cancel = () => clearTimeout(longPressTimer);
    document.addEventListener("touchend", cancel, { once: true });
    document.addEventListener("touchmove", cancel, { once: true });
  }
});

// Carregamento inicial
renderFilms(films);
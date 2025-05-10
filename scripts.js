// Lista de downloads
const downloads = [
  {
    id: "1",
    link: "https://example.com/file.zip",
    title: "Download Exemplo",
    category: "By me",
    year: "2025",
    video: "https://youtu.be/6s8_GnbYDoY?si=u6qpNaFZZBYCpe1q",
    image: "icons/error.png",
    canSee: true
  },
];

// Carrega dark mode se estiver salvo
if (localStorage.getItem("dark") === "true") {
  document.body.classList.add("dark");
}

// Alterna dark mode
document.getElementById("darkToggle").addEventListener("click", () => {
  document.body.classList.toggle("dark");
  localStorage.setItem("dark", document.body.classList.contains("dark"));
});

// Renderiza os downloads na tela
function renderDownloads(list) {
  const container = document.getElementById("download-category");
  container.innerHTML = "";

  list.forEach(item => {
    if (item.canSee === false) return;

    const el = document.createElement("div");
    el.className = "download-item";
    el.innerHTML = `
      <img src="${item.image}" alt="${item.title}" onerror="this.src='icons/error.png'">
      <h3>${item.title}</h3>
      <p>${item.category} / ${item.year}</p>
      <button class="download-button" data-id="${item.id}">Download</button>
    `;
    container.appendChild(el);
  });

  protegerImagens();
}

// Protege imagens contra clique e arrasto
function protegerImagens() {
  const imagens = document.querySelectorAll('#download-category img');
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
  const results = downloads.filter(item =>
    item.title.toLowerCase().includes(query)
  );
  renderDownloads(results);
});

// Sistema de busca com Enter
document.getElementById("search-bar").addEventListener("keydown", (e) => {
  if (e.key === "Enter") {
    document.getElementById("search-button").click();
  }
});

// Delegação de evento para botões de download
document.getElementById("download-category").addEventListener("click", (e) => {
  if (e.target.classList.contains("download-button")) {
    const id = e.target.dataset.id;
    const downloadItem = downloads.find(d => d.id === id);
    if (downloadItem) {
      window.location.href = downloadItem.link;
    }
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
renderDownloads(downloads);

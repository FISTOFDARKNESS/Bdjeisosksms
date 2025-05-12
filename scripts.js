const downloads = [
  {
    id: "1",
    link: "https://workink.net/1ZCI/AnimationSpoofer",
    title: "Animation Spoofer V3",
    category: "_.yzero",
    year: "2025 (with video)",
    video: "https://youtu.be/cjwyrrIeZFw?si=P7l66FEJdqg0AW77",
    image: "icons/AnimationSpoofer.png",
    canSee: true
  },
    {
    id: "2",
    link: "https://workink.net/1ZCI/MoonAnimatorV4",
    title: "Moon Animator V4",
    category: "_.yzero",
    year: "2025 (with video)",
    video: "https://youtu.be/eC8ZL0Vemnc?si=-2q7o07tFy0rrCHe",
    image: "icons/MoonAnimator.png",
    canSee: true
  },
   {
    id: "3",
    link: "https://workink.net/1ZCI/ModuleLightingManager",
    title: "Module Lighting Manager",
    category: "_.yzero",
    year: "2025 (no video)",
    video: "https://www.youtube.com/@SkyyDev",
    image: "icons/LightingManager.png",
    canSee: true
  },
  {
    id: "4",
    link: "https://workink.net/1ZCI/AdvancedTweenModule",
    title: "Advanced Tween Module",
    category: "_.yzero",
    year: "2025 (no video)",
    video: "https://www.youtube.com/@SkyyDev",
    image: "icons/tween.png",
    canSee: true
  },
  {
    id: "5",
    link: "https://workink.net/1ZCI/TojiDomainBreak",
    title: "Toji Domain Break",
    category: "_.yzero",
    year: "2025 (with video)",
    video: "https://youtu.be/4ccAgxlc1M8?si=WIBTrjSl8uDVVbV2",
    image: "icons/toji1.png",
    canSee: true
  },
    {
    id: "6",
    link: "https://workink.net/1ZCI/NigiNiceToMeetYouJapan",
    title: "Nigi Nice To Meet You Japan",
    category: "_.yzero",
    year: "2025 (with video)",
    video: "https://youtu.be/8LrTeg4qxlU?si=XEJrQi0fuqKqzsdl",
    image: "icons/nagi.png",
    canSee: true
  },
      {
    id: "7",
    link: "https://workink.net/1ZCI/MalevolentShrine",
    title: "Malevolent Shrine",
    category: "_.yzero",
    year: "2025 (with video)",
    video: "https://youtu.be/yeIosHoZonE?si=mTTCR_wGDu6O9gV7",
    image: "icons/MS.png",
    canSee: true
  },
  {
    id: "8",
    link: "https://workink.net/1ZCI/Comming",
    title: "Comming Sae Flow",
    category: "_.yzero",
    year: "2025 (13/05 with video)",
    video: "https://www.youtube.com/@SkyyDev",
    image: "icons/.png",
    canSee: true
  },
  {
    id: "9",
    link: "https://workink.net/1ZCI/Comming",
    title: "Comming Mahito Domain Expansion",
    category: "_.yzero",
    year: "2025 (13/05 with video)",
    video: "https://www.youtube.com/@SkyyDev",
    image: "icon/.png",
    canSee: true
  },
];
if (localStorage.getItem("dark") === "true") {
  document.body.classList.add("dark");
}
document.getElementById("darkToggle").addEventListener("click", () => {
  document.body.classList.toggle("dark");
  localStorage.setItem("dark", document.body.classList.contains("dark"));
});
function renderDownloads(list) {
  const container = document.getElementById("download-category");
  container.innerHTML = "";
  list.forEach(item => {
    if (item.canSee === false) return;
    const el = document.createElement("div");
    el.className = "download-item";
    el.innerHTML = `
      <div class="image-container">
        <img src="${item.image}" alt="${item.title}" onerror="this.src='icons/error.png'">
        <div class="play-icon" onclick="window.open('${item.video}', '_blank')">&#9654;</div> <!-- Ícone de Play -->
      </div>
      <h3>${item.title}</h3>
      <p>${item.category} / ${item.year}</p>
      <button class="download-button" data-id="${item.id}">Download</button>
    `;
    container.appendChild(el);
  });
  protegerImagens();
}
const style = document.createElement("style");
style.innerHTML = `
  .image-container {
    position: relative;
    display: inline-block;
  }
  .play-icon {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    font-size: 3rem;
    color: white;
    opacity: 0;
    transition: opacity 0.3s;
    cursor: pointer;
  }
  .image-container:hover .play-icon {
    opacity: 1; /* Aparece quando o mouse passa por cima da imagem */
  }
  img {
    width: 100%;
    height: auto;
  }
`;
document.head.appendChild(style);
function protegerImagens() {
  const imagens = document.querySelectorAll('#download-category img');
  imagens.forEach(img => {
    img.setAttribute('oncontextmenu', 'return false');
    img.setAttribute('draggable', 'false');
    img.style.pointerEvents = 'none';
  });
}
document.getElementById("logout").addEventListener("click", () => {
  localStorage.removeItem("loggedInUser");
  window.location.href = "auth.html";
});
document.getElementById("search-button").addEventListener("click", () => {
  const query = document.getElementById("search-bar").value.toLowerCase();
  const results = downloads.filter(item =>
    item.title.toLowerCase().includes(query)
  );
  renderDownloads(results);
});
document.getElementById("search-bar").addEventListener("keydown", (e) => {
  if (e.key === "Enter") {
    document.getElementById("search-button").click();
  }
});
document.getElementById("download-category").addEventListener("click", (e) => {
  if (e.target.classList.contains("download-button")) {
    const id = e.target.dataset.id;
    const downloadItem = downloads.find(d => d.id === id);
    if (downloadItem) {
      window.location.href = downloadItem.link;
    }
  }
});
document.addEventListener("contextmenu", (e) => e.preventDefault());
document.addEventListener("selectstart", (e) => e.preventDefault());
document.addEventListener("touchstart", (e) => {
  if (e.target.tagName !== "INPUT" && e.target.tagName !== "TEXTAREA") {
    let longPressTimer = setTimeout(() => e.preventDefault(), 500);
    const cancel = () => clearTimeout(longPressTimer);
    document.addEventListener("touchend", cancel, { once: true });
    document.addEventListener("touchmove", cancel, { once: true });
  }
});
renderDownloads(downloads);

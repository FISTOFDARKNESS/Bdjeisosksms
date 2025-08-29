document.getElementById("activateBtn").addEventListener("click", async () => {
  const key = document.getElementById("keyInput").value;
  const device = document.getElementById("deviceInput").value;
  const messageEl = document.getElementById("message");

  if (!key || !device) {
    messageEl.textContent = "Preencha todos os campos!";
    return;
  }

  try {
    const res = await fetch("/.netlify/functions/keysystem", {
      method: "POST",
      body: JSON.stringify({ key, device }),
    });
    const data = await res.json();
    messageEl.textContent = data.message;
  } catch (err) {
    messageEl.textContent = "Erro ao conectar ao servidor.";
  }
});

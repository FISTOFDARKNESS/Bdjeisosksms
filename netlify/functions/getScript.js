import fs from "fs";
import path from "path";

export async function handler(event, context) {
  const { key, name } = event.queryStringParameters;

  // 🚨 Edite aqui o seu token secreto
  const SECRET = "5fa946debf7a4d8f87751afa9bbb238c";

  if (key !== SECRET) {
    return {
      statusCode: 403,
      body: "Acesso negado: token inválido."
    };
  }

  if (!name) {
    return {
      statusCode: 400,
      body: "Erro: especifique ?name=nomedoarquivo"
    };
  }

  const filePath = path.join("scripts", `${name}.lua`);

  try {
    const script = fs.readFileSync(filePath, "utf8");
    return {
      statusCode: 200,
      body: script
    };
  } catch (e) {
    return {
      statusCode: 404,
      body: "Script não encontrado."
    };
  }
}

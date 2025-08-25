import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

// Para obter o __dirname no ESM
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// 🚨 Seu token secreto
const SECRET = "5fa946debf7a4d8f87751afa9bbb238c";

export async function handler(event, context) {
  try {
    const { key, name } = event.queryStringParameters || {};

    // Verifica token
    if (key !== SECRET) {
      return {
        statusCode: 403,
        body: "Acesso negado: token inválido."
      };
    }

    // Verifica se nome do arquivo foi fornecido
    if (!name) {
      return {
        statusCode: 400,
        body: "Erro: especifique ?name=nomedoarquivo"
      };
    }

    // Sanitiza o nome para evitar path traversal
    const sanitized = path.basename(name);
    const filePath = path.join(__dirname, "scripts", `${sanitized}.lua`);

    // Lê o arquivo
    if (!fs.existsSync(filePath)) {
      return {
        statusCode: 404,
        body: "Script não encontrado."
      };
    }

    const script = fs.readFileSync(filePath, "utf8");

    return {
      statusCode: 200,
      body: script
    };
  } catch (error) {
    console.error(error);
    return {
      statusCode: 500,
      body: "Erro interno do servidor."
    };
  }
}

import fs from "fs";
import path from "path";

export async function handler(event, context) {
  const { key, name } = event.queryStringParameters;

  // Token de acesso
  const SECRET = "MEU_TOKEN_SUPER_SECRETO";
  if (key !== SECRET) {
    return {
      statusCode: 403,
      body: "Acesso negado"
    };
  }

  // Caminho do script pedido
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
      body: "Script não encontrado"
    };
  }
}

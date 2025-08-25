import fs from "fs";
import path from "path";
export async function handler(event, context) {
  const { key, name } = event.queryStringParameters;
  const SECRET = "5fa946debf7a4d8f87751afa9bbb238c";
  if (key !== SECRET) {
    return {
      statusCode: 403,
      body: "Acesso negado"
    };
  }
  const filePath = path.join(process.cwd(), "scripts", `${name}.lua`);
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

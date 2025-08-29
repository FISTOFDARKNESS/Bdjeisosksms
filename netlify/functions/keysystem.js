let keysDB = [
  { key: "ABC123", device: null, usado: false },
  { key: "XYZ789", device: null, usado: false },
];

exports.handler = async (event) => {
  if (event.httpMethod !== "POST") {
    return { statusCode: 405, body: "Método não permitido" };
  }

  const { key, device } = JSON.parse(event.body);

  const keyObj = keysDB.find((k) => k.key === key);

  if (!keyObj) {
    return { statusCode: 200, body: JSON.stringify({ message: "Key inválida!" }) };
  }

  if (!keyObj.device) {
    keyObj.device = device;
    keyObj.usado = true;
    return { statusCode: 200, body: JSON.stringify({ message: "Key ativada com sucesso!" }) };
  }

  if (keyObj.device === device) {
    return { statusCode: 200, body: JSON.stringify({ message: "Key já ativada neste dispositivo." }) };
  }

  return { statusCode: 200, body: JSON.stringify({ message: "Esta key já foi usada em outro dispositivo." }) };
};

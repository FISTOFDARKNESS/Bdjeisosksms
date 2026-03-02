const fetch = require('node-fetch'); // Certifique-se de que a dependência está instalada

exports.handler = async (event, context) => {
    const assetId = event.queryStringParameters.id;

    if (!assetId) {
        return { statusCode: 400, body: "ID do asset é obrigatório." };
    }

    try {
        // O link para áudios é o mesmo, mas o servidor do Roblox 
        // frequentemente faz um redirecionamento (302) para a URL final do arquivo.
        const url = `https://assetdelivery.roblox.com/v1/asset/?id=${assetId}`;
        
        const response = await fetch(url, {
            headers: {
                // Se o áudio for privado, você precisaria adicionar o cookie aqui
                // 'Cookie': `.ROBLOSECURITY=${process.env.ROBLOSECURITY}`
            },
            redirect: 'follow' // Importante: segue o redirecionamento do Roblox
        });

        if (!response.ok) {
            return { statusCode: response.status, body: "Falha ao baixar áudio." };
        }

        const buffer = await response.buffer();

        return {
            statusCode: 200,
            headers: {
                "Content-Type": "audio/ogg", // Define como áudio
                "Content-Disposition": `attachment; filename="audio_${assetId}.ogg"`
            },
            body: buffer.toString('base64'),
            isBase64Encoded: true
        };

    } catch (error) {
        return { statusCode: 500, body: error.toString() };
    }
};

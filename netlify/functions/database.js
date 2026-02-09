import { neon } from '@neondatabase/serverless';

export const handler = async (event) => {
  const sql = neon(process.env.DATABASE_URL);

  try {
    if (event.httpMethod === 'GET') {
      const data = await sql`SELECT * FROM downloads ORDER BY release_date DESC`;
      return {
        statusCode: 200,
        body: JSON.stringify(data),
      };
    }

    if (event.httpMethod === 'POST') {
      const { name, email, rating, type, message } = JSON.parse(event.body);
      await sql`
        INSERT INTO feedback (name, email, rating, type, message)
        VALUES (${name}, ${email}, ${rating}, ${type}, ${message})
      `;
      return {
        statusCode: 200,
        body: JSON.stringify({ success: true }),
      };
    }
  } catch (error) {
    return {
      statusCode: 500,
      body: JSON.stringify({ error: error.message }),
    };
  }
};

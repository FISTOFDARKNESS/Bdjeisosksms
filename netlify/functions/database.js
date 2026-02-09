import { neon } from '@neondatabase/serverless';

export const handler = async (event) => {
  const sql = neon("postgresql://neondb_owner:npg_ZIigvq76hfeD@ep-lucky-night-ahauzl87-pooler.c-3.us-east-1.aws.neon.tech/neondb?sslmode=require&channel_binding=require");

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

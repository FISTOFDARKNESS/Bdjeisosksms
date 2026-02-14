
import { neon } from '@neondatabase/serverless';

export const handler = async (event: any) => {
  if (event.httpMethod !== 'POST') {
    return { statusCode: 405, body: 'Method Not Allowed' };
  }

  const sql = neon("postgresql://neondb_owner:npg_ZIigvq76hfeD@ep-lucky-night-ahauzl87-pooler.c-3.us-east-1.aws.neon.tech/neondb?sslmode=require&channel_binding=require");
  
  try {
    const { name, email, rating, type, message } = JSON.parse(event.body);
    
    await sql`
      INSERT INTO feedback (name, email, rating, type, message)
      VALUES (${name}, ${email}, ${rating}, ${type}, ${message})
    `;

    return {
      statusCode: 201,
      body: JSON.stringify({ success: true }),
      headers: { 'Content-Type': 'application/json' }
    };
  } catch (error: any) {
    return {
      statusCode: 500,
      body: JSON.stringify({ error: error.message })
    };
  }
};

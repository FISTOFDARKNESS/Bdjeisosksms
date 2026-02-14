
import { neon } from '@neondatabase/serverless';

export const handler = async () => {
  const sql = neon("postgresql://neondb_owner:npg_ZIigvq76hfeD@ep-lucky-night-ahauzl87-pooler.c-3.us-east-1.aws.neon.tech/neondb?sslmode=require&channel_binding=require");
  
  try {
    const data = await sql`SELECT * FROM downloads ORDER BY release_date DESC`;
    return {
      statusCode: 200,
      body: JSON.stringify(data),
      headers: { 'Content-Type': 'application/json' }
    };
  } catch (error: any) {
    return {
      statusCode: 500,
      body: JSON.stringify({ error: error.message })
    };
  }
};

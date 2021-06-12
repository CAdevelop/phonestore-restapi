import sql from "mssql";
import config from "../config";

export const dbSettings = {
  user: config.user,
  password: config.password,
  server: config.server,
  database: config.database,
  options: {
    encrypt: true, // for azure
    trustServerCertificate: true, // change to true for local dev / self-signed certs
  },
};

export const getConnection = async () => {
  try {
    const pool = await sql.connect(dbSettings);
    return pool;
  } catch (error) {
    console.error(error);
  }
};

export { sql };

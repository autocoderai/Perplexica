import { drizzle } from 'drizzle-orm/better-sqlite3';
import Database from 'better-sqlite3';
import * as schema from './schema';
import path from 'path';

const dbPath = path.join(__dirname, '..', '..', 'data', 'db.sqlite');
const sqlite = new Database(dbPath, {
  permissions: {
    user: 'node',
  },
});
const db = drizzle(sqlite, {
  schema: schema,
});

export default db;

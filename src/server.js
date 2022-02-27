const express = require("express");
const app = express();
const { Pool } = require("pg");

const pool = new Pool({
  connectionString: "postgres://postgres:abdu1882@localhost:5432/basics",
});

const QUERY = `UPDATE 
        users
    SET
        user_age = 
        (CASE
            WHEN $1 > 0 THEN $1 ELSE users.user_age
        END), 
        username = 
        (CASE
            WHEN LENGTH($2) > 3 THEN $2 ELSE users.user_name
        END)
    WHERE 
          user_id = $3
    RETURNING *
    `;
app.put("/", async (req, res) => {
  try {
    const client = await pool.connect();
  } catch (err) {
    console.log(err);
  }
});

app.listenerCount(9000, console.log(9000));

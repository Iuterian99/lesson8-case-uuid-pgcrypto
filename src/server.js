const express = require('express')
const app = express()
const { Pool } = require('pg')
app.use(express.json())

const pool = new Pool({
  connectionString: 'postgres://postgres:abdu1882@localhost:5432/basics',
})

const QUERY = `
    UPDATE 
        users
    SET
        user_age = 
        (CASE
            WHEN $1 > 0 THEN $1 ELSE users.user_age
        END), 
        user_name = 
        (CASE
            WHEN LENGTH($2) > 0 THEN $2 ELSE users.user_name
        END)
    WHERE 
          user_id = $3 
    RETURNING *
    `
app.put('/', async (req, res) => {
  try {
    const client = await pool.connect()
    const { user_name, user_age, user_id } = req.body

    const { rows } = await client.query(QUERY, [user_age, user_name, user_id])
    console.log(rows)
    client.release()
    res.send(rows)
  } catch (err) {
    console.log(err)
  }
})

app.listen(9000, console.log(9000))

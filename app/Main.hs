{-# LANGUAGE OverloadedStrings #-}

import Database.SQLite.Simple

main :: IO ()
main = do
    conn <- open "test.db"

    execute_ conn
        "CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, name TEXT)"

    execute conn
        "INSERT INTO users (name) VALUES (?)"
        (Only ("Agneay" :: String))

    rows <- query_ conn
        "SELECT id, name FROM users" :: IO [(Int, String)]

    mapM_ print rows

    close conn

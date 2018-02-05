require 'sqlite3'
require 'pry'

DB = { :conn => SQLite3::Database.new('./artists.db') }

def create_table
  sql = <<-SQL
    CREATE TABLE artists (
      id INTEGER PRIMARY KEY,
      name TEXT
    )
  SQL

  DB[:conn].execute(sql)
end

def drop_table
  sql = <<-SQL
    DROP TABLE artists
  SQL

  DB[:conn].execute(sql)
end

def create(name)
  sql = <<-SQL
    INSERT INTO artists (name) VALUES (?)
  SQL

  DB[:conn].execute(sql, name)
end

def read(id)
  sql = <<-SQL
    SELECT * FROM artists WHERE id = (?)
  SQL

  DB[:conn].execute(sql, id)
end

def update(name, id)
  sql = <<-SQL
    UPDATE artists SET name = ? WHERE id = ?
  SQL

  DB[:conn].execute(sql, name, id)
end

def delete(id)
  sql = <<-SQL
    DELETE from artists WHERE id = ?
  SQL

  DB[:conn].execute(sql, id)
end

def show_all
  sql = <<-SQL
    SELECT * from artists
  SQL

  DB[:conn].execute(sql)
end

def show_last
  sql = <<-SQL
    SELECT * from artists ORDER BY id DESC LIMIT 1
  SQL

  DB[:conn].execute(sql)
end

Pry.start

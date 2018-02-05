require 'sqlite3'
require 'pry'

DB = { :conn => SQLite3::Database.new('./artists.db') }

class Artist
  attr_reader :name, :id

  def initialize(name, id=nil)
    @name = name
    @id = id
  end

  def self.create(name)
    sql = <<-SQL
      INSERT INTO artists (name) VALUES (?)
    SQL

    DB[:conn].execute(sql, name)
    Artist.show_last
  end

  def read
    sql = <<-SQL
      SELECT * FROM artists WHERE id = (?)
    SQL

    response = DB[:conn].execute(sql, self.id)[0]

    Artist.format_sql(response)
  end

  def update(name, hometown=self.hometown)
    sql = <<-SQL
      UPDATE artists SET name = ? WHERE id = ?
    SQL

    DB[:conn].execute(sql, name, self.id)

    self.read
  end

  def self.all
    sql = <<-SQL
      SELECT * from artists
    SQL

    response = DB[:conn].execute(sql)

    # [Artist(1), [2, "Snoop"], [3, "Snoop"]]
    response.map{|row| Artist.format_sql(row)}
  end

  private
  def self.show_last
    sql = <<-SQL
      SELECT * from artists ORDER BY id DESC LIMIT 1
    SQL

    response = DB[:conn].execute(sql)
    # [[3, "Snoop"]]
    format_sql(response[0])
  end

  def self.format_sql(response)
    # [3, "Snoop"]
    Artist.new(response[1], response[0])
  end

end

Pry.start

require 'sinatra'
require 'sqlite3'

configure do
  @db = SQLite3::Database.new 'STORAGE.db'
  @db.execute 'CREATE TABLE IF NOT EXISTS "STORAGE" ("id" INTEGER PRIMARY KEY AUTOINCREMENT, "CATEGORIES" VARCHAR(100), "GIVER" VARCHAR(100), "DATE_OF" VARCHAR(100), "TITLE" VARCHAR(100), "SERIAL" VARCHAR(100), "BALANCE" VARCHAR(100), "ADDINF" VARCHAR(500), LOCATION VARCHAR(100));'
end

get '/' do
  'Hello world!'
end

get '/tech' do
  erb :technics
end

post '/tech' do
  erb :technics
end

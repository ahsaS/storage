require 'sinatra'
require 'sqlite3'

configure do
  @db = SQLite3::Database.new 'STORAGE.db'
  @db.execute 'CREATE TABLE IF NOT EXISTS "STORAGE" ("id" INTEGER PRIMARY KEY AUTOINCREMENT, "CATEGORIES" VARCHAR(100), "GIVER" VARCHAR(100), "DATE_OF" VARCHAR(100), "TITLE" VARCHAR(100), "SERIAL" VARCHAR(100), "BALANCE" VARCHAR(10), "ADDINF" VARCHAR(500), "LOCATION" VARCHAR(100));'
end

def get_db
  db = SQLite3::Database.new 'STORAGE.db'
  db.results_as_hash = true
  return db
end

get '/' do
  'Hello world!'
end

get '/tech' do
  erb :technics
end

post '/tech' do
  @what = params[:what]
  @whogiver = params[:whogiver]
  @dtof = params[:dtof]
  @title = params[:title]
  @sernum = params[:sernum]
  @balance = params[:balans]
  @addinf = params[:addinf]
  @location = params[:location]
  db = get_db
  db.execute 'INSERT INTO STORAGE(CATEGORIES, GIVER, DATE_OF, TITLE, SERIAL, BALANCE, ADDINF, LOCATION) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', [@what, @whogiver, @dtof, @title, @sernum, @balance, @addinf, @location]
  erb :technics

end

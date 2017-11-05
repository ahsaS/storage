require 'sinatra'
require 'sqlite3'

configure do
  db = SQLite3::Database.new 'STORAGE.db'
  db.execute 'CREATE TABLE IF NOT EXISTS "STORAGE" ("id" INTEGER PRIMARY KEY AUTOINCREMENT, "CATEGORIES" VARCHAR(100), "GIVER" VARCHAR(100), "DATE_OF" VARCHAR(100), "TITLE" VARCHAR(100), "SERIAL" VARCHAR(100), "BALANCE" VARCHAR(10), "ADDINF" VARCHAR(500), "LOCATION" VARCHAR(100));'
  db.execute 'CREATE TABLE IF NOT EXISTS "SENDED" ("id" INTEGER PRIMARY KEY AUTOINCREMENT, "CATEGORIES" VARCHAR(100), "GIVER" VARCHAR(100), "DATE_OF" VARCHAR(100), "TITLE" VARCHAR(100), "SERIAL" VARCHAR(100), "BALANCE" VARCHAR(10), "ADDINF" VARCHAR(500), "LOCATION" VARCHAR(100));'
end

def get_db
  db = SQLite3::Database.new 'STORAGE.db'
  db.results_as_hash = true
  return db
end

before do
  get_db
end

get '/' do
  erb 'Hello world!'
end

get '/showtech' do
  @result = {}
  erb :showtechnics
end

post '/showtech' do
  @wht = params[:what]
  @whgvr = params[:whogiver]
  @result = []
  db = get_db
  @result = db.execute 'SELECT * FROM STORAGE WHERE CATEGORIES=? AND GIVER=?', [@wht, @whgvr]
  erb :showtechnics
end

post '/sendtech' do
  @result = {}
  @id = params[:id]
  db = get_db
  @tomove = db.execute 'SELECT * FROM STORAGE WHERE id=?', [@id]
  tomove = @tomove[0]
  db.execute 'INSERT INTO SENDED(CATEGORIES, GIVER, DATE_OF, TITLE, SERIAL, BALANCE, ADDINF, LOCATION) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', [tomove['CATEGORIES'], tomove['GIVER'], tomove['DATE_OF'], tomove['TITLE'], tomove['SERIAL'], tomove['BALANCE'], tomove['ADDINF'], params[:destination]]
  db.execute 'DELETE FROM STORAGE WHERE id=?', [@id]
  erb :showtechnics
end

get '/addtech' do
  erb :technics
end

post '/tech' do
  @what = params[:what]
  @whogiver = params[:whogiver]
  @dtof = params[:dtof]
  @title = params[:title]
  @sernum = params[:sernum]
  @balance = params[:balance]
  @addinf = params[:addinf]
  @location = params[:location]
  db = get_db
  db.execute 'INSERT INTO STORAGE(CATEGORIES, GIVER, DATE_OF, TITLE, SERIAL, BALANCE, ADDINF, LOCATION) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', [@what, @whogiver, @dtof, @title, @sernum, @balance, @addinf, @location]
  erb :technics
end

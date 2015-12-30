require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def get_db
  db = SQLite3::Database.new 'barbershop.sqlite' 
  db.results_as_hash = true
  return db
end

configure do  
  db = get_db
  db.execute 'CREATE TABLE IF NOT EXISTS 
              "Users" 
              ("id" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , 
                "username" TEXT, 
                "phone" TEXT, 
                "datestamp" TEXT, 
                "barber" TEXT, 
                "color" TEXT
                )'  
end


get '/' do
  erb :index
end

get '/visit' do
  erb :visit
end

post '/visit' do
  @username = params[:username]
  @phone = params[:phone]
  @datetime = params[:datetime]
  @barber = params[:barber]
  @color = params[:color]

  err_hash = {:username => 'Введите имя',
              :phone => 'Введите телефон',
              :datetime => 'Введите дату и время',
              :color => 'Выберите цвет'}

  err_hash.each do |key, value|
    if params[key] == ''
      @error = err_hash[key]
      return erb :visit
    end
  end

  db = get_db
  db.execute 'insert into 
              Users 
              (
                username, 
                phone, 
                datestamp, 
                barber, 
                color
              ) 
              values (?, ?, ?, ?, ?)', [@username, @phone, @datetime, @barber, @color]

  erb "Отлично, #{@username}, мастер #{@barber} будет Вас ждать в #{@datetime}"

end

get '/about' do
  erb :about
end

get '/contacts' do
  erb :contacts
end

get '/showusers' do
  db = get_db
  db.results_as_hash = true

  db.execute 'select * from Users' do |row|
    #erb "#{row['username']} записался на #{row['datestamp']}"
  end

  erb :showusers
end
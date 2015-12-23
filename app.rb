require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

configure do
  enable :sessions
end


get '/' do
  erb :index
end

get '/visit' do
  erb :visit
end

get '/about' do
  erb :about
end

get '/contacts' do
  erb :contacts
end
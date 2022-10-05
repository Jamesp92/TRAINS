require('sinatra')
require('sinatra/reloader')
require('./lib/city')
require('./lib/train')
require('pry')
require("pg")

also_reload('lib/**/*.rb')

DB = PG.connect({dbname: 'train_system_test'})

get('/') do
  erb(:index)
end

get('/trains') do
  @trains = Train.list_all()
  erb(:trains)
end

get('/cities') do
  @cities = City.list_all()
  erb(:cities)
end

get('/stops') do
  erb(:stops)
end

get('/cities/new') do
  erb(:city_new)
end

post('/cities') do
  city = City.new(name: params[:city_name], id: nil) # params are important
  city.save()
  redirect to('/cities')
end

get('/cities/:id') do
  @city = City.find(:id) # params are important
  erb(:city)
end

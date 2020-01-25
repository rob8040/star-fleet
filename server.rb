require 'sinatra'
require_relative 'config/application'

set :bind, '0.0.0.0'  # bind to all interfaces

enable :sessions

# Any classes you add to the models folder will automatically be made available in this server file

get '/' do
  redirect '/starships'
end

get '/starships' do
  # Use a custom Starship class that inherits from ActiveRecord to retrieve your database objects
  # You should be using ActiveRecord CRUD methods to aid you.
  # E.g. Planet.where(planet_type: "gas giant"), etc.
  @starships = Ship.all

  erb :'starships/index'
end

get '/crew_members' do
  @crew_members = CrewMember.order(:last_name)
  erb :'starships/crew_members'
end

get '/starships/starship_new' do
  erb :'starships/starship_new'
end

post "/starships" do
  @id = params[:id]
  @name = params[:name]
  @ship_class = params[:ship_class]
  @location = params[:location]

  @new_ship = Ship.new(params)

  if @new_ship.save
    flash[:notice] = "You've succesfully added a ship!"
    redirect "/starships/#{@new_ship.id}"
  else
    flash.now[:error] = @new_ship.errors.full_messages.to_sentence
    erb :'starships/starship_new'
  end

end

post "/crew_members" do
  # @id = params[:id]
  @ship_id = params[:id]
  @first_name = params[:first_name]
  @last_name = params[:last_name]
  @specialty_division = params[:specialty_division]

  @starship = Ship.find(params["ship_id"])

  @new_crew = CrewMember.new(params)

  if @new_crew.save
    flash[:notice] = "You've succesfully added a crew member!"
    redirect "/crew_members"
  else
    flash.now[:error] = @new_crew.errors.full_messages.to_sentence
    erb :'starships/starship_show'
  end

end

get '/starships/:id' do
  @starship = Ship.find(params["id"])
  erb :'starships/starship_show'
end

# get '/crew_members/:id' do
#   @crew_member = CrewMember.find(params["id"])
# end

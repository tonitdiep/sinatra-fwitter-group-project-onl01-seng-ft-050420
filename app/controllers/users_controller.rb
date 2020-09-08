class UsersController < ApplicationController

get '/signup' do 
  
    erb :signup
  end
post '/signup' do 
    @user = User.create(username: params[:username], password: params[:password], email: params[:email])
    redirect '/signup'
  end
end

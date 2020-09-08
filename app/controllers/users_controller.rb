require 'pry'
class UsersController < ApplicationController

  get '/signup' do 

    erb :'/users/signup'
  end
  post '/signup' do 
  # binding.pry
    @user = User.create(username: params[:username], password: params[:password], email: params[:email])
    redirect '/users/signup'
  end
end

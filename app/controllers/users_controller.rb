require 'pry'
class UsersController < ApplicationController

  get '/signup' do 

    erb :'/users/signup'
  end
  post '/signup' do 
    @user = User.create(username: params[:username], password: params[:password], email: params[:email])
      if @user.valid?    
            session[:user_id] = @user.id
            redirect '/tweets/index'
      else
            redirect '/users/signup'
      end
  end
  
  get '/login' do
    
    erb :'/users/login'
  end
  # post '/login' do 
 
  #   @user = User.create(username: params[:username], password: params[:password], email: params[:email])
  #       if @user.valid?    
  #           session[:user_id] = @user.id
  #         redirect '/tweets/index'  
  #       else
  #         redirect '/users/login'
  #       end
        
  # end
  
end

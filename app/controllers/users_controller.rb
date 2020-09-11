require 'pry'

class UsersController < ApplicationController

  get '/signup' do 
      if !is_logged_in? 
        erb :'/users/signup'
      else
        redirect '/tweets'
      end
  end
  
  post '/signup' do 
   
      if params[:username]  != "" && params[:email] != "" && params[:password] != ""
        @user = User.create(username: params[:username], password: params[:password], email: params[:email])
      end  
      if @user
            session[:user_id] = @user.id
            redirect '/tweets/index'
      else 
            redirect '/users/signup'
      end
  end
  
  get '/login' do
    if !is_logged_in?
      erb :'/users/login'
    else
      redirect '/tweets/index'
    end
  end
  post '/login' do 
    @user = User.find_by_username(params[:username])
   
    if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
          flash[:message] = "Welcome"
        redirect '/tweets'  
    else
 
        redirect '/users/login'
    end
        
  end
  
  get '/logout' do 
    session.destroy
    redirect '/login'
  end
  
  
end

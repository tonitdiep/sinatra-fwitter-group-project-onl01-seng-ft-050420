class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
    if !!is_logged_in?
      erb :'/tweets/index'
    else
      redirect '/users/login'
    end
  end

  get '/tweets/:id' do

    @user = User.find_by_id(params[:id])
    erb :'/users/show'
  end
  
  post '/users' do  #creating a new user
    @user = User.create(username: params[:username], password: params[:password], email: params[:email])

    erb :'tweets/new'
  end
  
  
  
end

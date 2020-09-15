class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
    if !!is_logged_in?
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do

    erb :'/tweets/new'
  end
  
  post '/tweets' do 
    
    @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
    
    redirect "/tweets/#{@tweet.id}"
  end
  
  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/show_tweet'
  end
  

  
  
  
end

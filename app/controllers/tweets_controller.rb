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
    if is_logged_in?
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end
  
  post '/tweets' do 
    if is_logged_in? == params[:content]
      erb :'tweets/new'
    else
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      redirect "/tweets/#{@tweet.id}"
    end
  end
  
  get '/tweets/:id' do #show action
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/show_tweet'
  end
  
  get '/tweets/:id/edit' do #load edit form

    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/edit'
  end
  
  patch '/tweets/:id' do
    # binding.pry
    @tweet = Tweet.udpate(content: params[:content], user_id: current_user.id)
      # @tweet = Tweet.find_by_id(params[:id])
      # @tweet.content = params[:content]
      # @tweet.user_id = params[:user_id]
      # @tweet.save
      erb :'/tweets/show_tweet'
    # else
      # redirect "/tweets/#{@tweet.id}"
  end
  
  delete '/tweets/:id' do 
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.delete 
      redirect '/tweets'
  end
  
  
end

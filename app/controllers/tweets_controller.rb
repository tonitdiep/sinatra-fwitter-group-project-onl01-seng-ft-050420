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
    if current_user && params[:content] == ""
      redirect "tweets/new"
    else
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      redirect "/tweets/#{@tweet.id}"
    end
  end
  
  get '/tweets/:id' do #show action
    if is_logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end
  
  get '/tweets/:id/edit' do #load edit form
  # binding.pry
    if is_logged_in? 
      @tweet = Tweet.find_by_id(params[:id])
        if @tweet.user == current_user
           erb :'/tweets/edit'
        end
    else 
      redirect '/login'
    end
  end
  
  patch '/tweets/:id' do
    if params[:content] != ""
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.update(content: params[:content])
      erb :'/tweets/show_tweet'
    else
      redirect '/tweets/edit/'
    end
  end
  
  delete '/tweets/:id' do 
          
    if is_logged_in? && current_user == @tweet.id

      # @tweet = Tweet.find_by_content(params[:content])
      @tweet.destroy 
      redirect '/login'
    end
  end
  
  
end

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
# binding.pry
    if is_logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end
  
  # [#<Tweet id: 1, content: "submit this is content via tweets/1/edit", user_id: 5>, #<Tweet id: 2, content: "blueberries and apples",user_id: 3>, #<Tweet id: 3, content: "creating this tweet again", user_id: 3>]
  
#   [["id", 3], ["LIMIT", 1]]
# => #<User id: 3, username: "toni", email: "toni@toni.com", password_digest: "$2a$12$Mf9u3tOWF6Xl.j3SbDnvsO9lgtoNLYuKrr5op6Gy3Sb...">

# [["id", 5], ["LIMIT", 1]]
# => #<User id: 5, username: "basil", email: "basil@basil.com", password_digest: "$2a$12$rOMGM7eBdDJ35M/eBw5SOucdgBJdTMp6xEyLabpLyS8...">
  get '/tweets/:id/edit' do #load edit form
  # binding.pry
    if is_logged_in? 
      @tweet = Tweet.find_by_id(params[:id])
        if @tweet.user == current_user
           erb :'/tweets/edit'
          
        else
          redirect '/tweets'
          
        end
    else 
      redirect '/login'
    end
    
  end
  
  patch '/tweets/:id' do
# binding.pry
        if is_logged_in? && params[:content] != "" 
          # is_logged_in? && params[:content] != "" && current_user
          @tweet = Tweet.find_by_id(params[:id])
          @tweet.update(content: params[:content]) 
          redirect "/tweets/#{@tweet.id}"
        else
          redirect "/tweets/#{params[:id]}/edit"
              
        end 
    
  end
  
  delete '/tweets/:id' do 
    
    if is_logged_in? 
      
      @tweet = Tweet.find_by_id(params[:id])
        if @tweet.user_id == current_user.id 
          @tweet.destroy 
        end
      redirect '/tweets'
      
    else
        redirect '/login'   
    end
    
  end

  
end

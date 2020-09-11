class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
  end
end

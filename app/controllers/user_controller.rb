class UserController < ApplicationController
  get '/login' do
    erb :"users/login"
  end

  post '/login' do
    erb :"users/show"
  end
end

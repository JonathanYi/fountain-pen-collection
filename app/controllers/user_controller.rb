class UserController < ApplicationController
  get '/login' do
    erb :"users/login"
  end

  post '/login' do
    #binding.pry
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      binding.pry
      redirect "/collectionsTest"
    end
    #erb :"/collections"
  end

  get '/collectionsTest' do
    binding.pry
    #if logged_in?
      @collections = current_user.collections
      erb :"collections/collections"
    #end
  end
end

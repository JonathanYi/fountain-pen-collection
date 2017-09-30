class UserController < ApplicationController
  get '/login' do
    erb :"users/login"
  end

  post '/login' do
    #binding.pry
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/collections"
    end
    #erb :"/collections"
  end
end

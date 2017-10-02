require 'rack-flash'
class UserController < ApplicationController
  use Rack::Flash

  get '/signup' do
    if logged_in?
      redirect "/collections"
    else
      erb :"/users/create_user"
    end
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      erb :"users/show"
    else
      flash[:message] = "Please Try Again. All fields should be filled out."
      redirect "/signup"
    end
  end

  get '/login' do
    if logged_in?
      redirect "/collections"
    else
      erb :"users/login"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    #username or password was blank
    if params[:username] == "" || params[:password] == ""
      redirect "/login"
    elsif @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      erb :"/users/show"
    else
      #username and/or oassword invalid
    end
  end

  get '/logout' do
    session.clear
    redirect "/login"
  end
end

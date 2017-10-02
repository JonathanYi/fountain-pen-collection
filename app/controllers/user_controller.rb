class UserController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect "/collections"
    else
      erb :"/users/create_usr.erb"
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

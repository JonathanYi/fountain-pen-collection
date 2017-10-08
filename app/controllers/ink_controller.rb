require 'rack-flash'
class InkController < ApplicationController
    use Rack::Flash

    get '/inks' do
      if logged_in?
        @inks = current_user.inks
        erb :"inks/inks"
      else
        redirect "/login"
      end
    end

    get '/inks/new' do
      if logged_in?
        @inks = current_user.inks
        @collections = current_user.collections
        erb :"inks/create_ink"
      else
        redirect "/login"
      end
    end

    post '/inks' do
      #binding.pry
      if params[:name] == "" || params[:brand] == ""
        flash[:message] = "Please fiill out name and brand."
        redirect "/inks/new"
      else
        @ink = Ink.create(params)
        @ink.user_id = current_user.id
        @ink.save
        redirect "/inks/#{@ink.slug}"
      end
    end
end

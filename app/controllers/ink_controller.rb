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

    get '/inks/:slug' do
      if logged_in?
        @ink = Ink.find_by_slug(params[:slug])

        if !!@ink & current_user.inks.include?(@ink)
          erb :"inks/show"
        else
          flash[:message] = "Ink #{params[:slug]} was not found."
          redirect "/inks"
        end
      else
        redirect "/login"
      end
    end

    delete '/inks/:slug/delete' do
      if logged_in?
        @ink = Ink.find_by_slug(params[:slug])
        if @ink.user_id = current_user.id
          @ink.delete
          redirect "/inks"
        else
          redirect to "/inks"
        end
      else
        redirect "/login"
      end
    end
end

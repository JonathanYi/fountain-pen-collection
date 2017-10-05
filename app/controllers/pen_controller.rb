require 'rack-flash'
class PenController < ApplicationController
  use Rack::Flash

  get '/pens' do
    if logged_in?
      @pens = current_user.pens
      erb :"pens/pens"
    else
      redirect "/login"
    end
  end

  get '/pens/:slug' do
    if logged_in?
      @pen = Pen.find_by_slug(params[:slug])
      @inks = Ink.all
      if !!@pen & current_user.pens.include?(@pen)
        erb :"pens/show"
      else
        flash[:message] = "Pen #{params[:slug]} was not found."
        redirect "/pens"
      end
    else
      redirect "/login"
    end
  end
end

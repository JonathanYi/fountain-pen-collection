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

  get '/pens/new' do
    if logged_in?
      @inks = Ink.all
      erb :"pens/create_pen"
    else
      redirect "/login"
    end
  end

  post '/pens' do
    #binding.pry
    if params[:name] == "" || params[:brand] == ""
      flash[:message] = "Please fiill out name and brand."
      redirect "/pens/new"
    else
      @pen = Pen.create({name: params[:name], brand: params[:brand]})
      #i thought this would have populated during save but it doens't?
      #better to do this in the route or on the page?
      #@pen.user = current_user
      @pen.ink = Ink.find(params[:ink])
      @pen.save
      redirect "/pens/#{@pen.slug}"
    end
  end

  get '/pens/:slug' do
    if logged_in?
      @pen = Pen.find_by_slug(params[:slug])
      @inks = Ink.all
      if @pen.ink == nil
        @current_ink = "No Ink"
      else
        @current_ink = @pen.ink.name
      end
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

  patch '/pens/:slug' do
    #binding.pry
    @pen = Pen.find_by_slug(params[:slug])
    @pen.ink = Ink.find(params[:ink])
    @pen.save
    redirect "/pens/#{@pen.slug}"
  end

  delete '/pens/:slug/delete' do
    if logged_in?
      @pen = Pen.find_by_slug(params[:slug])
      if @pen.user_id = current_user.id
        @pen.delete
        redirect "/pens"
      else
        redirect to "/pens"
      end
    else
      redirect "/login"
    end
  end
end

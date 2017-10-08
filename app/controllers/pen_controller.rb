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
      @inks = current_user.inks
      @collections = current_user.collections
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
      if !!params[:ink_id]
        @pen.ink_id = Ink.find(params[:ink_id])
      end
      if !!params[:collection_id]
        @pen.collection_id = params[:collection_id]
      end
      @pen.user_id = current_user.id
      @pen.save
      redirect "/pens/#{@pen.slug}"
    end
  end

  get '/pens/:slug' do
    if logged_in?
      @pen = Pen.find_by_slug(params[:slug])
      @inks = Ink.all
      @collections = current_user.collections
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
    if !!params[:ink]
      @pen.ink = Ink.find(params[:ink])
    end
    if !!params[:collection]
      @pen.collection_id = params[:collection]
    end
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

require 'rack-flash'
class CollectionController < ApplicationController
  use Rack::Flash

  get '/collections' do
    if logged_in?
      @collections = current_user.collections
      erb :"collections/collections"
    else
      redirect "/login"
    end
  end

  post '/collections' do
    #binding.pry
    @collection = Collection.find_or_create_by(name: params[:collection][:name])
    #i thought this would have populated during save but it doens't?
    #better to do this in the route or on the page?
    @collection.user = current_user
    @collection.pen_ids = params[:collection][:pen_ids]
    @collection.save
    redirect "/collections/#{@collection.slug}"
  end

  get '/collections/new' do
    if logged_in?
      @pens = Pen.all
      erb :"collections/create_collection"
    else
      redirect "/login"
    end
  end

  get '/collections/:slug' do
    if logged_in?
      @collection = Collection.find_by_slug(params[:slug])
      @pens = Pen.all
      if !!@collection & current_user.collections.include?(@collection)
        erb :"collections/show"
      else
        flash[:message] = "Collection #{params[:slug]} was not found."
        redirect "/collections"
      end
    else
      redirect "/login"
    end
  end

  patch '/collections/:slug' do
    #binding.pry
    @collection = Collection.find_by_slug(params[:slug])
    @collection.pen_ids = params[:pens]
    @collection.save
    redirect "/collections/#{@collection.slug}"
  end

  delete '/collections/:slug/delete' do
    if logged_in?
      @collection = Collection.find_by_slug(params[:slug])
      if @collection.user_id = current_user.id
        @collection.delete
        redirect "/collections"
      else
        redirect to "/collections"
      end
    else
      redirect "/login"
    end
  end
end

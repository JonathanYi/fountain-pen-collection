class CollectionController < ApplicationController
  get '/collections' do
    if logged_in?
      @collections = current_user.collections
      erb :"collections/collections"
    end
  end

  post '/collections' do
    #binding.pry
    @collection = Collection.find_or_create_by(name: params[:collection][:name])
    #i thought this would have populated during save but it doens't?
    #better to do this in the route or on the page?
    @collection.user = current_user
    @collection.pen_ids = params[:collection][:pen__ids]
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
    @collection = Collection.find_by_slug(params[:slug])
    @pens = Pen.all
    erb :"collections/show"
  end

  patch '/collections/:slug' do
    #binding.pry
    @collection = Collection.find_by_slug(params[:slug])
    @collection.pen_ids = params[:pens]
    @collection.save
    redirect "/collections/#{@collection.slug}"
  end
end

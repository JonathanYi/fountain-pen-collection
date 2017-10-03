class CollectionController < ApplicationController
  get '/collections' do
    if logged_in?
      @collections = current_user.collections
      erb :"collections/collections"
    end
  end

  post '/collections' do
    @collection = Collection.create(params[:collection])
    #i thought this would have populated during save but it doens't?
    #better to do this in the route or on the page?
    @collection.user = current_user
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
    erb :"collections/show"
  end

end

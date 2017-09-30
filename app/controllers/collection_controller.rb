class CollectionController < ApplicationController
  get '/collections' do
    if logged_in?
      @collections = current_user.collections
      erb :"collections/collections"
    end
  end

  get '/collections/:slug' do
    @collection = Collection.find_by_slug(params[:slug])
    erb :"collections/show"
  end
end

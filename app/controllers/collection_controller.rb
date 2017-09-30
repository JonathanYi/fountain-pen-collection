class CollectionController < ApplicationController
  get '/collections' do
    binding.pry
    if logged_in?
      @collections = current_user.collections
      erb :"collections/collections"
    end
  end
end

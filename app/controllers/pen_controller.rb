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
end

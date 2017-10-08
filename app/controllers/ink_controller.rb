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
end

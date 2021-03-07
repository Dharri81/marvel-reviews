require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    register Sinatra::Flash
    set :session_secret, 'secret'
  end

  helpers do
    def authorize
      redirect '/login' unless session[:user_id]
    end
  end

  get "/" do
    erb :welcome
  end
end

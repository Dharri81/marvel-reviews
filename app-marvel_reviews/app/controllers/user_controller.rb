class UserController < ApplicationController
    
    get '/signup' do
        erb :'users/signup'
    end
    
    get '/login' do
        erb :'users/login'
    end

    get '/logout' do
        authorize
        session[:user_id] = nil
        redirect '/login'
    end

    post '/users' do
        u = User.create(params)
        if u.valid?
            session[:user_id] = u.id
            redirect "/users/#{u.id}"
        else
            flash[:error] = "User exist"
            redirect '/signup'
        end
    end

    post '/login' do
        u = User.find_by(username: params[:username])
        if u and u.authenticate(params[:password])
            session[:user_id] = u.id
            redirect "/users/#{u.id}"
        else
            flash[:error] = "Invalid Login"
            redirect '/signup'
        end
    end    

    get '/users/:id' do
        authorize
        @user = User.find_by(id: params[:id])
        @reviews = Review.all
        erb :'users/show'
    end
end

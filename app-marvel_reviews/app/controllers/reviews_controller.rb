class ReviewsController < ApplicationController


    get "/reviews/new" do
        authorize
        erb :'reviews/new'
    end

    post "/reviews" do
        authorize
        review = Review.new(params)
        review.user_id = session[:user_id]
        if review.save
            redirect "/reviews/#{review.id}"
        else
            flash[:error] = "review not saved"
            redirect '/reviews/new'
        end
    end

    get '/reviews/:id' do
        authorize
        @review = Review.find_by(id: params[:id])
        erb :'reviews/show'
    end

    post '/reviews/:id' do
        authorize
        if Review.update(params[:id], params)
            redirect "/reviews/#{params[:id]}"
        else
            flash[:error] = "review not updated"
            redirect '/reviews/<%= params[:id] %>'
        end
    end

    get '/reviews/:id/edit' do
        authorize
        @review = Review.find_by(id: params[:id])
        erb :'reviews/edit'
    end

    get '/reviews/:id/delete' do
        authorize
        if Review.destroy(params[:id])
            redirect "/users/#{session[:user_id]}"
        else
            flash[:error] = "review not deleted"
            redirect '/reviews/<%= params[:id] %>'
        end
    end
end

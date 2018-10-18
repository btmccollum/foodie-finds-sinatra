class PostController < ApplicationController

    # get '/categories/:state/posts/new' do
    #     @state = State.find_by(params[:state])
    # end

    get '/categories/:state/posts' do
        @state = State.find_by(name: params[:state])
        @posts = Post.where(state_id: @state.id)
        
        erb :'/categories/show'
    end

    # patch '/categories/:state/posts/:id' do
    #     @state = State.find_by(params[:state])
    # end
end
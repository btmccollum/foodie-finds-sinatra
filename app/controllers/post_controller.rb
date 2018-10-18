class PostController < ApplicationController

    get '/categories/:state/posts/new' do
        @state = State.find_by(name: params[:state])

        erb :'/posts/new'
    end
    
    get '/categories/:state/posts/:id' do
        @state = State.find_by(name: params[:state])
        @post = Post.find(params[:id])
        @comments = Comment.where(post_id: @post.id)

        erb :'/posts/show'
    end

    get '/categories/:state/posts' do
        @state = State.find_by(name: params[:state])
        @posts = Post.where(state_id: @state.id)
        
        erb :'/categories/show'
    end

    post '/categories/:state/posts' do 
        @state = State.find_by(name: params[:state])
        @post = Post.new(title: params[:title], city: params[:city], location: params[:location], content: params[:content], score: 0)
        @post.state_id = @state.id
        @post.user_id = current_user.id
        @post.save

        redirect :"/categories/#{@state.name}/posts/#{@post.id}"
    end


    # patch '/categories/:state/posts/:id' do
    #     @state = State.find_by(params[:state])
    # end
end
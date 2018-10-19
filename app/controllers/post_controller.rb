class PostController < ApplicationController

    get '/categories/:category/posts/new' do
        if logged_in
            @category = Category.find_by(title: params[:category])

            erb :'/posts/new'
        else 
            flash[:message] = "You must be logged in to create a post." 
            redirect '/users/login'
        end
    end
    
    get '/categories/:category/posts/:id' do
        @category = Category.find_by(title: params[:category])
        @post = Post.find(params[:id])
        @comments = Comment.where(post_id: @post.id)

        erb :'/posts/show'
    end

    get '/categories/:category/posts' do
        @category = Category.find_by(title: params[:category])
        @posts = Post.where(category: @category.id)
        
        erb :'/categories/show'
    end

    post '/categories/:category/posts' do 
        binding.pry
        if !params.any?{|key, value| value == ""}
            @category = Category.find_by(title: params[:category])
            @post = Post.new(title: params[:title], city: params[:city], location: params[:location], content: params[:content], score: 0)
            @post.category_id = @category.id
            @post.user_id = current_user.id
            @post.save

            redirect :"/categories/#{@category.title}/posts/#{@post.id}"
        else 
            flash[:message] = "All fields required" 
            redirect '/categories/:category/posts/new'
        end
    end


    # patch '/categories/:category/posts/:id' do
    #     @category = Category.find_by(params[:category])
    # end
end
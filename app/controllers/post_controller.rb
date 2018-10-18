class PostController < ApplicationController

    get '/categories/:category/posts/new' do
        @category = Category.find_by(title: params[:category])

        erb :'/posts/new'
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
        @category = Category.find_by(title: params[:category])
        @post = Post.new(title: params[:title], city: params[:city], location: params[:location], content: params[:content], score: 0)
        @post.category_id = @category.id
        @post.user_id = current_user.id
        @post.save

        redirect :"/categories/#{@category.title}/posts/#{@post.id}"
    end


    # patch '/categories/:category/posts/:id' do
    #     @category = Category.find_by(params[:category])
    # end
end
class PostController < ApplicationController
    get '/categories/:category/posts/:id/edit' do
        if logged_in && is_post_owner(params)
            @category = Category.find_by(title: params[:category])
            @post = Post.find(params[:id])
            erb :'/posts/edit'
        else
            flash[:message] = "You cannot edit a post you did not create." 
            redirect '/'
        end
    end

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
        binding.pry
        @category = Category.find_by(title: params[:category])
        @posts = Post.where(category_id: @category.id)
        
        erb :'/categories/show'
    end

    post '/categories/:category/posts' do 
        @category = Category.find_by(title: params[:category])
        
        if !params["post"].any? {|key, value| value == ""}
            @post = Post.new(params["post"])
            @post.category_id = @category.id
            @post.user_id = current_user.id
            @post.score = 0
            @post.save

            redirect "/categories/#{@category.title}/posts/#{@post.id}"
        else 
            flash[:message] = "All fields required" 
            redirect '/categories/:category/posts/new'
        end
    end


    patch '/categories/:category/posts/:id' do
        @category = Category.find_by(title: params[:category])

        if logged_in && is_post_owner(params)
            @post = Post.find(params[:id])
            params["post"].each do |key, value|
                if value != ""
                    @post.update(key => value)
                else
                    next
                end
            end
            redirect "/categories/#{@category.title}/posts/#{@post.id}"
        else
            flash[:message] = "You cannot edit a post you did not create." 
            redirect '/'
        end
    end

    delete '/categories/:category/posts/:id/delete' do
        @category = Category.find_by(title: params[:category])

        if logged_in && is_post_owner(params)
            @post = Post.find(params[:id])
            @post.destroy
            redirect "/categories/#{@category.title}/posts"
        else
            flash[:message] = "You cannot delete a post you did not create." 
            redirect '/categories/#{@category.title}/posts'
        end
    end
end
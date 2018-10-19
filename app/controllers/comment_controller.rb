class CommentController < ApplicationController
    get '/categories/:category/posts/:id/comments/new' do
        @category = Category.find_by(title: params[:category])
        @post = Post.find(params[:id])

        if logged_in
            erb :'/comments/new'
        else 
            flash[:message] = "You must be logged in to reply." 
            redirect "/categories/#{@category.title}/posts/#{@post.id}"
        end
    end

    post '/categories/:category/posts/:id/comments' do
        @category = Category.find_by(title: params[:category])
        @post = Post.find(params[:id])
binding.pry
        if logged_in 
            @comment = Comment.new(params["comment"])
            @comment.user_id = current_user.id
            @comment.post_id = @post.id
            @comment.score = 1
            @comment.save
            
            redirect "/categories/#{@category.title}/posts/#{@post.id}"
        else 
            flash[:message] = "You must be logged in to reply." 
            redirect "/categories/#{@category.title}/posts/#{@post.id}"
        end
    end
end
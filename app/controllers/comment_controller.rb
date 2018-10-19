class CommentController < ApplicationController
    get '/categories/:category/posts/:id/comments/:comment_id/edit' do
        @category = Category.find_by(title: params[:category])
        @post = Post.find(params[:id])
        
        if logged_in && is_comment_owner(params)
            @comment = Comment.find(params[:comment_id])
           
            erb :'/comments/edit'
        else
            flash[:message] = "You cannot edit a comment you did not create." 
            redirect "/categories/#{@category.title}/posts/#{@post.id}"
        end
    end

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

    patch '/categories/:category/posts/:id/comments/:comment_id' do
        @category = Category.find_by(title: params[:category])
        @post = Post.find(params[:id])

        if logged_in && is_comment_owner(params)
            @comment = Comment.find(params[:comment_id])
            params["comment"].each do |key, value|
                if value != ""
                    @comment.update(key => value)
                else
                    next
                end
            end
            redirect "/categories/#{@category.title}/posts/#{@post.id}"
        else
            flash[:message] = "You cannot edit a post you did not create." 
            redirect "/categories/#{@category.title}/posts/#{@post.id}"
        end
    end

    delete '/categories/:category/posts/:id/comments/:comment_id/delete' do
        @category = Category.find_by(title: params[:category])
        @post = Post.find(params[:id])

        if logged_in && is_comment_owner(params)
            @comment = Comment.find(params[:comment_id])
            @comment.destroy
            redirect "/categories/#{@category.title}/posts/#{@post.id}"
        else
            flash[:message] = "You cannot delete a comment you did not create." 
            redirect "/categories/#{@category.title}/posts/#{@post.id}"
        end
    end
end
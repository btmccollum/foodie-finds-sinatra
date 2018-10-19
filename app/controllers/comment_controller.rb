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
end
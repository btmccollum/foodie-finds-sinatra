#future implementation of category overview functions

class CategoryController < ApplicationController

    get '/categories/:category' do
        @category = Category.find_by(title: params[:category])
        redirect "/categories/#{@category.title}/posts"

        # @categories = Category.all
        # @category = Category.find_by(title: params[:category])
        # @posts = Post.where(category_id: params[:id])
        
        # erb :'/categories/show'
    end
    
end
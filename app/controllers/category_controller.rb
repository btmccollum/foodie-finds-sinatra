class CategoryController < ApplicationController

    get '/categories/:category' do
        @catergory = Category.find_by(title: params[:category])
        
        erb :'/categories/show'
    end
    
end
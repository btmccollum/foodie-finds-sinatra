class CategoryController < ApplicationController

    get '/categories/:category' do
        binding.pry
        @catergory = Category.find_by(title: params[:category])
        
        erb :'/categories/show'
    end
    
end
class CategoryController < ApplicationController

    get '/categories/:state' do
        binding.pry
        @state = State.find_by(name: params[:state])
        
        erb :'/categories/show'
    end
    
end
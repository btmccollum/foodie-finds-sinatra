class UserController < ApplicationController
    get '/users/signup' do
        erb :'/users/create_new'
    end

    get '/login' do
    end

    post '/signup' do
    end

    post '/login' do 
    end

    get '/logout' do
    end
end
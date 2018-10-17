class UserController < ApplicationController
    get '/users/signup' do
        erb :'/users/create_new'
    end

    get '/users/login' do
        erb :'/users/login'
    end

    post '/signup' do
    end

    post '/login' do 
    end

    get '/logout' do
    end
end
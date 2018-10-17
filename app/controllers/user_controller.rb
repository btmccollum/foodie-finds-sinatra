class UserController < ApplicationController
    get '/users/signup' do
        erb :'/users/create_new'
    end

    get '/users/login' do
        erb :'/users/login'
    end

    post '/users/signup' do
        binding.pry
        if !params.any?{|key, value| value == ""}
            @user = User.new(:username => params["username"], :email => params["email"], :password => params["password"], :reputation => 0)
            if @user.save
                session[:user_id] = @user.id
                flash[:message] = "Account was successfully created."
                
                redirect '/'
            else
                flash[:message] = "Uh oh! Something went wrong. Please try again." 
                redirect '/users/signup'
            end
        else
            flash[:message] = "Invalid information provided. All fields are required. Please try again." 
            redirect '/users/signup'
        end
    end

    post '/login' do 
    end

    get '/users/logout' do
        if logged_in
            session.clear
            redirect '/'
        else 
            flash[:message] = "You cannot log out if you weren't ever logged in!" 
            redirect '/'
        end
    end
end
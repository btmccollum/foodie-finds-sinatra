class UserController < ApplicationController
    
    get '/users/:id/edit' do
        if logged_in && valid_user
            @user = current_user
            erb :'/users/edit'
        else
            flash[:message] = "You cannot view someone else's account." 
            redirect '/'
        end
    end

    get '/users/signup' do
        if logged_in
            flash[:message] = "You already have an account." 
            redirect '/'
        else 
            erb :'/users/new'
        end
    end

    get '/users/login' do
        if logged_in
            flash[:message] = "You are already logged in." 
            redirect '/'
        else
            erb :'/users/login'
        end
    end

    get '/users/logout' do
        if logged_in
            session.clear
            flash[:message] = "You have been successfully logged out." 
            redirect '/'
        else 
            flash[:message] = "You cannot log out if you weren't ever logged in!" 
            redirect '/'
        end
    end

    get '/users/:id' do
        if logged_in && valid_user
            @posts = Post.where(user_id: current_user.id)
            @user = current_user

            erb :'/users/show'
        elsif logged_in && !valid_user
            flash[:message] = "You cannot access another's profile." 
            redirect '/'
        else
            flash[:message] = "You must be logged in to access your profile." 
            redirect '/users/login'
        end
    end

    post '/users/signup' do
        if duplicate_username? && duplicate_email?
            flash[:message] = "This username and email have already been registered to an account." 
            redirect '/users/signup'
        elsif duplicate_username? && !duplicate_email?
            flash[:message] = "This username has already been taken, please choose another." 
            redirect '/users/signup'
        elsif !duplicate_username? && duplicate_email?
            flash[:message] = "An account has already been registered to this email address." 
            redirect '/users/signup'
        elsif !params.any?{|key, value| value == ""}
            @user = User.new(:username => params["user"]["username"].downcase, :email => params["user"]["email"].downcase, :password => params["user"]["password"], :reputation => 0)

            if @user.save
                session[:user_id] = @user.id
                flash[:message] = "Account was successfully created."
                redirect '/'
            else
                flash[:message] = "All fields are required." 
                redirect '/users/signup'
            end
        else
            flash[:message] = "Uh oh! Something went wrong. Please try again." 
            redirect '/users/signup'
        end
    end

    post '/users/login' do 
        @user = User.find_by(:username => params["username"])

        if @user && @user.authenticate(params["password"])
            session.clear
            session[:user_id] = @user.id
            flash[:message] = "Welcome, #{@user.username}!" 
            redirect '/'
        else 
            flash[:message] = "Uh oh! Something went wrong. Please try again." 
            redirect '/users/login'
        end
    end

    patch '/users/:id' do
        if logged_in && valid_user
            if current_user.authenticate(params["password"])
                params["user"].each do |key, value|
                    if duplicate_username? && duplicate_email?
                        flash[:message] = "This username and email have already been registered to an account." 
                        redirect "/users/#{current_user.id}/edit"
                    elsif duplicate_username? && !duplicate_email?
                        flash[:message] = "This username has already been taken, please choose another." 
                        redirect "/users/#{current_user.id}/edit"
                    elsif !duplicate_username? && duplicate_email?
                        flash[:message] = "An account has already been registered to this email address." 
                        redirect "/users/#{current_user.id}/edit"
                    else
                        next
                    end
                end
                params["user"].each {|key, value| value != "" ? current_user.update(key => value) : next}
                flash[:message] = "Account successfully updated!" 
                redirect "/users/#{current_user.id}"
            else
                flash[:message] = "Incorrect password" 
                redirect "/users/#{current_user.id}"
            end
        else
            flash[:message] = "You must be logged in to edit your account." 
            redirect '/'
        end
    end
end
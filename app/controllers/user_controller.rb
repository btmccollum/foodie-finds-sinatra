class UserController < ApplicationController
    get '/users/signup' do
        erb :'/users/create_new'
    end

    get '/users/login' do
        erb :'/users/login'
    end

    get '/users/profile/:id/edit' do
        if logged_in && current_user.id == params[:id].to_i
            @user = current_user
            erb :'/users/edit'
        else
            flash[:message] = "You cannot view someone else's account." 
            redirect '/'
        end
    end

    get '/users/profile/:id' do
        if logged_in && session[:user_id] == current_user.id
            @posts = Post.where(user_id: current_user.id)
            @user = current_user
            erb :'/users/show'
        else
            flash[:message] = "You must be logged in to access your profile." 
            redirect '/users/login'
        end
    end

    post '/users/signup' do
        name_dup_check = !!User.find_by(username: params["user"]["username"])
        email_dup_check = !!User.find_by(email: params["user"]["email"]) 

        if name_dup_check && email_dup_check
            flash[:message] = "This username and email have already been registered to an account." 
            redirect '/users/signup'
        elsif name_dup_check && !email_dup_check
            flash[:message] = "This username has already been taken, please choose another." 
            redirect '/users/signup'
        elsif !name_dup_check && email_dup_check
            flash[:message] = "An account has already been registered to this email address." 
            redirect '/users/signup'
        elsif !params.any?{|key, value| value == ""}
            @user = User.new(:username => params["user"]["username"].downcase, :email => params["user"]["email"], :password => params["user"]["password"], :reputation => 0)

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

    post '/users/login' do 
        @user = User.find_by(:username => params["username"])

        if @user && @user.authenticate(params["password"])
            session.clear
            session[:user_id] = @user.id
            flash[:message] = "Welcome, #{@user.username}" 
            redirect '/'
        else 
            flash[:message] = "Uh oh! Something went wrong. Please try again." 
            redirect '/users/login'
        end
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
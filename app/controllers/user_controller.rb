class UserController < ApplicationController
    
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
        binding.pry
        if logged_in && current_user.id == params[:id].to_i
            @posts = Post.where(user_id: current_user.id)
            @user = current_user
            erb :'/users/show'
        elsif logged_in && current_user.id != params[:id].to_i
            flash[:message] = "You cannot access another's profile." 
            redirect '/'
        else
            flash[:message] = "You must be logged in to access your profile." 
            redirect '/users/login'
        end
    end

    get '/users/signup' do
        if logged_in
            flash[:message] = "You already have an account." 
            redirect '/'
        else 
            erb :'/users/create_new'
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
            flash[:message] = "You have been successfully logged out." 
            redirect '/'
        else 
            flash[:message] = "You cannot log out if you weren't ever logged in!" 
            redirect '/'
        end
    end

    patch '/users/profile/:id' do
        name_dup_check = !!User.find_by(username: params["user"]["username"])
        email_dup_check = !!User.find_by(email: params["user"]["email"]) 
        
        if logged_in && current_user.id == params[:id].to_i
            @user = current_user
            if @user.authenticate(params["user"]["password"])
                params["user"].each do |key, value|
                    if name_dup_check && email_dup_check
                        flash[:message] = "This username and email have already been registered to an account." 
                        redirect "/users/profile/#{@user.id}/edit"
                    elsif name_dup_check && !email_dup_check
                        flash[:message] = "This username has already been taken, please choose another." 
                        redirect "/users/profile/#{@user.id}/edit"
                    elsif !name_dup_check && email_dup_check
                        flash[:message] = "An account has already been registered to this email address." 
                        redirect "/users/profile/#{@user.id}/edit"
                    elsif value !=""
                        @user.update(key => value)
                    else 
                        next
                    end
                end
                flash[:message] = "Account successfully updated!" 
                redirect "/users/profile/#{@user.id}"
            else
                flash[:message] = "Incorrect password" 
                redirect "/users/profile/#{@user.id}"
            end
        else
            flash[:message] = "You must be logged in to edit your account." 
            redirect '/'
        end
    end
end
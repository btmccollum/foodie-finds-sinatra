require './config/environment'

class ApplicationController < Sinatra::Base

  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
  end

  get "/" do
    @posts = Post.order('created_at DESC').limit(10)
    @categories = Category.all
   
    erb :home
  end

  helpers do
    def current_user
      if session[:user_id]
        @current_user ||= User.find(session[:user_id])
      end
    end

    def valid_user
      current_user.id == params[:id].to_i ? true : false
    end

    def is_post_owner
      @post = Post.find(params[:id])
      @post.user_id == current_user.id ? true : false
    end

    def duplicate_username?
      User.find_by(username: params["user"]["username"]) ? true : false
    end

    def duplicate_email?
      User.find_by(email: params["user"]["email"]) ? true : false
    end

    def is_comment_owner
      @comment = Comment.find(params[:comment_id])
      @comment.user_id == current_user.id ? true : false
    end

    def logged_in
      !!current_user
    end
  end
end

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
    @posts = Post.order('created_at DESC').limit(5)
    @categories = Category.all
   
    erb :home
  end

  helpers do
    def current_user
      if session[:user_id]
        @current_user ||= User.find(session[:user_id])
      end
    end

    def is_post_owner(params)
      @post = Post.find(params[:id])
      @post.user_id == current_user.id ? true : false
    end

    def is_comment_owner(params)
      @comment = Comment.find(params[:comment_id])
      @comment.user_id == current_user.id ? true : false
    end

    def logged_in
      !!current_user
    end
  end
end

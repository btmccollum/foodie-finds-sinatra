class User < ActiveRecord::Base
    has_many :posts
    has_many :comments
    belongs_to :category

    validates_presence_of :username, :email, :password_digest
    validates_uniqueness_of :username, :email
    
    has_secure_password
end
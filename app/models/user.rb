class User < ActiveRecord::Base
    has_many :posts
    has_many :comments
    belongs_to :category

    has_secure_password
end
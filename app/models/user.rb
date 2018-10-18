class User < ActiveRecord::Base
    has_many :posts
    has_many :comments
    belongs_to :state

    has_secure_password
end
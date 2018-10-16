class User < ActiveRecord::Base
    has_many :posts
    has_many :comments
    belongs_to :city
    has_one :state, through: :city

    has_secure_password
end
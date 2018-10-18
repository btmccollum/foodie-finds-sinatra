class Category < ActiveRecord::Base
    belongs_to :state
    has_many :posts
    has_many :comments, through: :posts
end
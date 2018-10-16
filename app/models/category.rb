class Category < ActiveRecord::Base
    belongs_to :city
    has_one :state, through: :city
    has_many :posts
    has_many :comments, through: :posts
end
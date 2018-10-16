class Post < ActiveRecord::Base
    belongs_to :user
    belongs_to :city
    has_one :state, through: :city
    has_many :comments
end
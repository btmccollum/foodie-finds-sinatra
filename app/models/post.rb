class Post < ActiveRecord::Base
    belongs_to :user
    belongs_to :state
    has_many :comments
end
class State < ActiveRecord::Base
    has_many :cities
    has_many :posts, through: :cities
end
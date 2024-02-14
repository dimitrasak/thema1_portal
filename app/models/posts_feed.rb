class PostsFeed < ApplicationRecord
    validates :category, presence: true
end

class Post < ApplicationRecord
    after_create :notify_pusher
    has_many :likes
    
    def notify_pusher
        Pusher.trigger('feed', 'new-post', self.as_json(include: :likes))
    end
end


    
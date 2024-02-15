class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  after_create_commit { broadcast_append_to self.room }
  before_create :confirm_participant

  has_noticed_notifications

  after_create_commit :notify_user

  def notify_user
    MessageNotifier.with(message: self).deliver_later(user)
  end
  
  def confirm_participant
    if self.room.is_private
      is_participant = Participant.where(user_id: self.user.id, room_id: self.room.id).first
      throw :abort unless is_participant
    end
  end
end
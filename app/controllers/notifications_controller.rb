class NotificationsController < ApplicationController
  def index
        #@notifications = MessageNotifier.where(recipient: current_user).recent
        @notifications = current_user.noticed_notifications.recent if user_signed_in?


  end
end

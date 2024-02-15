# To deliver this notification:
#
# Message.with(record: @post, message: "New post").deliver(User.all)

class MessageNotifier < ApplicationNotifier
  deliver_by :database

  param :message

  def message
    params[:message].content
  end
  
  def url
    message_path(params[:message])
  end
  # Add your delivery methods
  #
  # deliver_by :email do |config|
  #   config.mailer = "UserMailer"
  #   config.method = "new_post"
  # end
  #
  # bulk_deliver_by :slack do |config|
  #   config.url = -> { Rails.application.credentials.slack_webhook_url }
  # end
  #
  # deliver_by :custom do |config|
  #   config.class = "MyDeliveryMethod"
  # end

  # Add required params
  #
  # required_param :message
end

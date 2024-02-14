class MessagesController < ApplicationController
    def create
      @current_user = current_user
      @room = Room.find(params[:room_id])
      @message = @current_user.messages.create(content: msg_params[:content], room: @room)
      #broadcast_to_room(@room, @message)
      respond_to do |format|
        format.html { redirect_to @room, notice: 'Message was successfully created.' }
        format.turbo_stream { render turbo_stream: turbo_stream.append("messages", partial: 'messages/message', locals: { message: @message }) }
        # Add other formats if needed (e.g., JSON, XML)
      end
      
    end
    private

  def msg_params
    params.require(:message).permit(:content)
  end
  def broadcast_to_room(room, message)
    # Broadcast the new message to the room's channel
    ActionCable.server.broadcast(room, turbo_stream.append(:messages, partial: 'messages/message', locals: { message: message }))
  end
end
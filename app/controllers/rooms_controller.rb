class RoomsController < ApplicationController
  def index
    @current_user = current_user
    redirect_to '/login' unless @current_user
    @users = User.all;
    @rooms = Room.public_rooms
    @room = Room.new

    
  end

  def create
    @room = Room.create(name: params["room"]["name"])
  end

  def show
    @current_user = current_user
    @single_room = Room.find(params[:id])
    @rooms = Room.public_rooms
    @users = User.all_except(@current_user)
    @room = Room.new
    @message = Message.new
  
    render "index"
  end


end

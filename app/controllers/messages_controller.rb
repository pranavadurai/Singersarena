class MessagesController < ApplicationController
  before_action do
   @conversation = Conversation.find(params[:conversation_id])
  end
  before_action :signed_in_user, only: [:index,:new,:create]

def index

end

def new
 @message = @conversation.messages.new
end

def create
 @message = @conversation.messages.new(message_params)
 if @message.save
   ActionCable.server.broadcast "messages_#{@conversation.id}",
   message: @message.body,
   user_name:    @message.user.name,
   conversation_id: @conversation.id,
   user_id: @message.user_id
   head :ok

 end
end

private
 def message_params
  params.require(:message).permit(:body, :user_id)
 end
end

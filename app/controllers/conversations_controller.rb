class ConversationsController < ApplicationController

  before_action :signed_in_user, only: [:index,:create,:show]


def index
  @conversations = Conversation.user_conversation(current_user.id)
  @users         = FollowerDetail.user_message(current_user.id)
end

def create
 if Conversation.between(params[:sender_id],params[:receiver_id]).present?
    @conversation = Conversation.between(params[:sender_id],params[:receiver_id]).first
 else
  @conversation = Conversation.create!(conversation_params)
 end
 redirect_to conversation_path(@conversation)
end

def show
  @conversation = Conversation.find(params[:id])
  @messages = @conversation.messages
  if @messages.last
    if @messages.last.user_id != current_user.id
      @messages.last.read = true
      @messages.last.update(update_params)
    end
  end
  @message = Message.new
end

private
 def conversation_params
  params.permit(:sender_id, :receiver_id)
 end

 def update_params
   params.permit(:read)
 end

end

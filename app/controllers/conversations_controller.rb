class ConversationsController < ApplicationController

  before_filter :signed_in_user, only: [:index]


def index
  @users = User.all
  @conversations = Conversation.all
end

def create
 if Conversation.between(params[:sender_id],params[:receiver_id]).present?
    @conversation = Conversation.between(params[:sender_id],params[:receiver_id]).first
 else
  @conversation = Conversation.create!(conversation_params)
 end
 redirect_to conversation_messages_path(@conversation)
end

def show
  @conversation = Conversation.find(params[:id])
  @messages = @conversation.messages
  if @messages.length > 10
    @over_ten = true
    @messages = @messages[-10..-1]
  end
  if params[:m]
    @over_ten = false
    @messages = @conversation.messages
  end
  if @messages.last
    if @messages.last.user_id != current_user.id
      @messages.last.read = true;
    end
  end

  @message = Message.new

end


private
 def conversation_params
  params.permit(:sender_id, :receiver_id)
 end

end

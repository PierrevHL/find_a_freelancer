class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = Conversation.where(sender: current_user).or(Conversation.where(receiver: current_user))
    @conversations = @conversations.joins(:messages).order("messages.created_at DESC").uniq
    @conversations.each { |conv| conv.contact = conv.contact_user(current_user) }
  end

  def create
    if Conversation.between(params[:sender_id], params[:receiver_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:receiver_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    redirect_to conversation_messages_path(@conversation)
  end

  private

  def conversation_params
    params.permit(:sender_id, :receiver_id)
  end
end

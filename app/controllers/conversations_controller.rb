class ConversationsController < ApplicationController
  layout 'conversations'
  def index
    @conversations = current_user.mailbox.conversations
    @serialized_conversations = ActiveModel::SerializableResource.new(@conversations, each_serializer: ConversationSerializer).as_json
  end

  def inbox
    @conversations = current_user.mailbox.inbox
    render action: :index
  end

  def sent
    @conversations = current_user.mailbox.sentbox
    render action: :index
  end

  def trash
    @conversations = current_user.mailbox.trash
    render action: :index
  end

  def show
    @conversations = current_user.mailbox.conversations
    @conversation = current_user.mailbox.conversations.find(params[:id])
    @conversation.mark_as_read(current_user)
    unless @conversation.messages.first.notified_object.nil?
      @notified_object = @conversation.messages.first.notified_object
    end
    @message = Mailboxer::Message.new
  end

  def new
    @conversation = Mailboxer::Conversation.new
    @recipients = User.all - [current_user]
  end

  def create
    recipients = User.where(id: params[:user_ids])
    receipt = current_user.send_message(recipients, params[:body], params[:subject])
    redirect_to conversation_path(receipt.conversation)
  end
end
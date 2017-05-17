class ChatsController < InheritedResources::Base
  # ---- layout ----

  layout 'admin'

  # ---- devise ----

  before_filter :authenticate_user!
  load_and_authorize_resource class: :user_chat

  # ---- breadcrumbs ----

  add_breadcrumb 'Mensagens', :chats_path

  # ---- actions ----

  def index
    @contacts = current_user.institution.users.where.not(id: current_user.id)
  end

  def messages
    ids = [params[:current_user_id].to_i, params[:contact_id].to_i]
    @talk_with = "Conversa com #{User.find(params[:contact_id].to_i).full_name}"
    @messages = UserChat.where { (user_id.in ids) & (contact_id.in ids) }
                        .order(:created_at)

    mark_as_read(params[:contact_id].to_i)

    render layout: false
  end

  def send_message
    if params[:message_content].present?
      @user_chat = UserChat.new

      @user_chat.message    = params[:message_content]
      @user_chat.user_id    = params[:current_user_id]
      @user_chat.contact_id = params[:contact_id]

      @user_chat.save
    end

    render nothing: true
  end


  # ---- methods ----

  private

  def chat_parameters
    params.require(:user_chat).permit!
  end

  def mark_as_read(contact_id)
    messages = UserChat.where(user_id: contact_id, contact_id: current_user.id, read: false)
    messages.update_all(read: true)
  end
end

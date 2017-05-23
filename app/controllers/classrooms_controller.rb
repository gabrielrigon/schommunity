class ClassroomsController < InheritedResources::Base
  # ---- layout ----

  layout 'admin'

  # ---- devise ----

  before_filter :authenticate_user!
  load_and_authorize_resource

  # ---- actions ----

  def forum
    @posts = resource.posts
                     .paginate(page: params[:page], per_page: 5)
                     .order('created_at desc')
  end

  def chat_counter
    @counter = ClassroomChat.where(classroom_id: params[:current_id].to_i)
                            .count
    render layout: false
  end

  def chat_messages
    classroom = Classroom.find(params[:current_id].to_i)
    @messages = ClassroomChat.where(classroom: classroom)
                             .order(:created_at)
    render layout: false
  end

  def chat_send_message
    if params[:message_content].present?
      @classroom_chat = ClassroomChat.new

      @classroom_chat.classroom_id = params[:current_id]
      @classroom_chat.content      = params[:message_content]
      @classroom_chat.user_id      = params[:current_user_id]
      @classroom_chat.save
    end

    render nothing: true
  end
end

module ChatsHelper
  def chat_badge_item(current, contact)
    messages = UserChat.where(user: contact, contact: current, read: false)

    if messages.any?
      content_tag(:small, class: 'label label-danger pull-right badge-count-messages') do
        messages.count.to_s
      end
    end
  end
end

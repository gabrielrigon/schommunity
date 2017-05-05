class PostDecorator < Draper::Decorator
  delegate_all

  def created_at
    object.created_at.strftime('%d-%m-%Y | %H:%M')
  end

  def active
    object.active ? 'Sim' : 'Não'
  end
end

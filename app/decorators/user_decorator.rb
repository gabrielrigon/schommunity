class UserDecorator < Draper::Decorator
  delegate_all

  def institution_trading_name
    object.institution_trading_name.presence || 'Administração'
  end
end

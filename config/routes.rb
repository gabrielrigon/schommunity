Rails.application.routes.draw do

  devise_for :users
  # devise
  root to: 'home#index'

end

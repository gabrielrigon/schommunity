Rails.application.routes.draw do

  devise_for :users

  # user types

  namespace :admin do
    resources :dashboard, only: :index
    
    resources :institutions
    resources :users
  end

  namespace :teachers do
  end

  namespace :students do
  end
end

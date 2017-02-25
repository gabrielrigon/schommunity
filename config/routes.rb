Rails.application.routes.draw do

  root 'admin/dashboard#index'

  devise_for :users

  # user types

  namespace :admin do
    resources :dashboard, only: :index

    resources :institutions
    resources :users
  end

  namespace :teachers do
    resources :courses
  end

  namespace :students do
  end
end

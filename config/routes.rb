Rails.application.routes.draw do

  root 'application#go_home'

  devise_for :users, path: '',
    path_names: { sign_in: 'sign_in',
                  sign_out: 'sign_out',
                  password: 'secret',
                  confirmation: 'verification',
                  unlock: 'unblock',
                  registration: 'register',
                  sign_up: 'cmon_let_me_in' }

  # user types

  namespace :admin do
    resources :dashboard, only: :index
    resources :institutions

    resources :users do
      collection do
        get 'student_course_field'
      end

      member do
        patch :resend_invitation
      end
    end
  end

  namespace :representatives do
    resources :classrooms do
      member do
        get :members
        patch :members
      end
    end
  end

  namespace :teachers do
    resources :dashboard, only: :index

    resources :classrooms do
      collection do
        get 'subject_field'
        get 'representative_field'
        get 'substitute_representative_field'
      end

      member do
        get :members
        patch :members
      end
    end

    resources :courses
    resources :subjects

    resources :users do
      collection do
        get 'search'
      end

      member do
        patch :resend_invitation
      end
    end
  end

  namespace :students do
    resources :dashboard, only: :index
  end

  # extras

  resources :chats do
    collection do
      get 'counter'
      get 'messages'
      post 'send_message'
    end
  end

  resources :posts do
    member do
      get :forum
      patch :forum
    end
  end

  resource :profile, only: :update
  get 'profile', action: :edit, controller: 'profiles'
end

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
    end
  end

  namespace :teachers do
    resources :dashboard, only: :index

    resources :classrooms do
      collection do
        get 'subject_field'
        get 'representative_field'
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
    end
  end

  namespace :students do
    resources :dashboard, only: :index
  end

  # extras

  resource :profile, only: :update
  get 'profile', action: :edit, controller: 'profiles'
end

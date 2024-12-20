Rails.application.routes.draw do
  devise_for :users
  
  root "dashboard#index"
  
  resources :teams do
    resources :projects, only: [:new, :create]
  end
  
  resources :projects, except: [:new, :create] do
    resources :tasks, shallow: true do
      member do
        patch :change_status
        patch :change_priority
      end
    end
  end
  
  resources :tasks, except: [:index] do
    resources :comments, shallow: true
  end
  
  get 'dashboard', to: 'dashboard#index'
end

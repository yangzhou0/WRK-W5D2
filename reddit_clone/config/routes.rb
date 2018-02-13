Rails.application.routes.draw do
  get 'comments/new'

  get 'comments/create'

  resources :subs
  resources :posts do
    resources :comments, only: :new
  end
  resources :comments, only: :create


  # resources :posts, except:[:create]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  
end

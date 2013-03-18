TodoApp::Application.routes.draw do
  root to: 'pages#front'

  resources :todos, only: [:index, :create, :new, :show]

  namespace :admin do
    resources :todos, only: [:index]
  end

  resources :sessions, only: [:create]
  get 'sign_out', to: "sessions#destroy"
end

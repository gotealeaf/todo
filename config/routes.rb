TodoApp::Application.routes.draw do
  root to: 'pages#front'

  resources :todos, only: [:index, :create, :new, :show]
  resources :sessions, only: [:create]
  get 'sign_out', to: "sessions#destroy"
end

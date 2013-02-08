TodoApp::Application.routes.draw do
  root to: 'todos#index'

  resources :todos, only: [:index, :create, :new, :show] do
  end
end

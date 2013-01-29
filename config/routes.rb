TodoApp::Application.routes.draw do
  root to: 'todos#index'

  resources :todos, only: [:index] do
    collection do
      get 'search', to: 'todos#search'
    end

    member do
      post 'highlight', to: 'todos#highlight'
    end
  end
end

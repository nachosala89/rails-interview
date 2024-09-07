Rails.application.routes.draw do
  root to: 'todo_lists#index'

  namespace :api do
    resources :todo_lists, only: %i[index], path: :todolists do
      resources :todo_items
    end
  end

  resources :todo_lists, only: %i[index new show], path: :todolists do
    resources :todo_items
  end
end

Rails.application.routes.draw do
  root to: 'todo_lists#index'

  namespace :api do
    resources :todo_lists, only: %i[index], path: :todolists do
      resources :todo_items
    end
  end

  resources :todo_lists, only: %i[index new create show], path: :todolists do
    member do
      post :complete_todo_items
    end
    
    resources :todo_items do
      member do
        patch :toggle_completed
      end
    end
  end
end

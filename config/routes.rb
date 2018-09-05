Rails.application.routes.draw do
  resources :users, only: :create do
    collection do
      post 'confirm'
      post 'login'
    end
  end

  root 'home#index'
  get '/login' => 'users#login_form'
end

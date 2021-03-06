Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq-scheduler/web'

  mount Sidekiq::Web => '/sidekiq'
  mount RailsAdmin::Engine => '/superadmin', as: 'rails_admin'

  devise_for :users, skip: [:sessions], controllers: { omniauth_callbacks: 'callbacks' }
  as :user do
    get 'users/sign_in' => redirect('/'), as: :new_user_session
    post 'users/sign_in' => 'devise/sessions#create', as: :user_session
    delete 'users/sign_out' => 'devise/sessions#destroy', as: :destroy_user_session
  end

  concern :proposable do
    post 'proposals' => 'proposals#update'
  end

  resources :gem_categories, path: 'categories', only: [:index, :show], concerns: :proposable
  resources :gem_objects, path: 'gems', only: [:show], concerns: :proposable

  get 'search' => 'application#search', as: :search
  get 'robots.txt', to: 'application#robots'
  get 'sitemap.xml', to: redirect(SITEMAP_URL)

  root 'application#home'

  # render 404 error if route does not exists
  get '*a', to: 'errors#error_404' if Environment.current?('production')
end

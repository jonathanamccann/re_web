Rails.application.routes.draw do
  resources :owners

  resources :parents

  resources :students

  resources :teachers

  resources :schools

  resources :organizations

  root                'static_pages#home'
  get    'help'    => 'static_pages#help'
  get    'about'   => 'static_pages#about'
  get    'contact' => 'static_pages#contact'
  get    'signup'  => 'users#new', :user => { :roleable_type => 'owner' }
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  get    '/home/owner/', to: 'owners#home', as: 'owner_home'

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :posts,               only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
end

Rails.application.routes.draw do
	
  resources :sku_combinations, only: [:index, :show, :new, :create]
  root to: 'dashboard#index'
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

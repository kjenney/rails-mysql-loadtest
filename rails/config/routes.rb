Rails.application.routes.draw do
  get 'welcome/index'

  resources :products
  resources :suppliers

  root 'welcome#index'
end

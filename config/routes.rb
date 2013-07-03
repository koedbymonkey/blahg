Blahg::Application.routes.draw do

  resources :stories

  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root to: 'welcome#index'

end

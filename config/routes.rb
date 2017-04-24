Rails.application.routes.draw do

  resources :colony_ants
  get 'info/bee'
  get 'info/ant'

  get 'welcome/index'

  resources :ants
  resources :bees

  get '/bees/algorithm/:id', to: 'bees#algorithm',  as: 'algorithmB'
  get '/ants/algorithm/:id', to: 'ants#algorithm',  as: 'algorithmA'
  get 'welcome/index'

  root :to => 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  get 'welcome/index'

  get 'info/ant'
  get 'info/bee'
  get 'info/colony_ant'

  resources :ants
  resources :bees
  resources :colony_ants

  get '/ants/algorithm/:id', to: 'ants#algorithm',  as: 'algorithmA'
  get '/bees/algorithm/:id', to: 'bees#algorithm',  as: 'algorithmB'
  get '/colony_ants/algorithm/:id', to: 'colony_ants#algorithm',  as: 'algorithmC'

  root :to => 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  get 'resultado/bee'

  get 'resultado/ant'

  get 'welcome/index'

  resources :ants
  resources :bees

  get '/bees/algorithm/:id', to: 'bees#algorithm', as: 'algorithm'
  get 'welcome/index'


  root :to => 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

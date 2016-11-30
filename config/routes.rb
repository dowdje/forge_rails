Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
  get '/access', to: 'welcome#access', as: :access
  get '/hubs', to: 'welcome#hubs', as: :hubs
  get '/auth', to: 'welcome#auth', as: :auth
end

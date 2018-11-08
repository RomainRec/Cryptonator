Rails.application.routes.draw do
  root 'static#home'
  resources :cryptos
  get  '/index',    to: 'cryptos#index'

  post '/scraper', to: 'cryptos#scraper'
  post '/search', to: 'cryptos#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

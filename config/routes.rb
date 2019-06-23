Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/destroy'
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
end

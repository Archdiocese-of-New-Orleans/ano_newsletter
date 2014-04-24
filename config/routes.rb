Rails.application.routes.draw do
  resources :newsletters, except: [:show], path: 'newsletter'
end

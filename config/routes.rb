AnoNewsletter::Engine.routes.draw do
  resources :newsletters, except: [:show]
end

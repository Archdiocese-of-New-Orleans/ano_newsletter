Rails.application.routes.draw do

  mount AnoNewsletter::Engine => "/", as: 'ano_newsletter'

end

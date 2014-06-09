AnoNewsletter
======
Newsletter app for the ano_ suite of rails engines

Add to your routes:
```ruby
mount AnoNewsletter::Engine => "/", as: 'ano_newsletter'
```

```
rake db:migrate
```

Add to your application.js & application.css (respectively):

//= require ano_newsletter
 *= require ano_newsletter
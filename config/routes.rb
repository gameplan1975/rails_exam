Rails.application.routes.draw do
  root 'blogs#top'
  resources :blogs
  
end

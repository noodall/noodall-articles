Rails.application.routes.draw do
  namespace :admin do
    resources :categories, :only => [:index]
  end
end

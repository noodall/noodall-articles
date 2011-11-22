require 'noodall/routes'
Dummy::Application.routes.draw do
  # Do something
  namespace :admin do
    resources :categories, :only => [:index]
  end
end

Noodall::Routes.draw(Dummy::Application)

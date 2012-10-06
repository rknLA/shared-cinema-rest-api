SharedCinema::Application.routes.draw do
  resources :videos do
    resources :votes 
  end

  resource :splash, :only => :index
  root :to => 'Splash#index'
end

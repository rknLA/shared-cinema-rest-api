SharedCinema::Application.routes.draw do
  resources :videos do
    resources :votes 
  end
end

SharedCinema::Application.routes.draw do
  resources :videos do
    member do
      post :vote
    end
  end
end

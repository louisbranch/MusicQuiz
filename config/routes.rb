MusicQuiz::Application.routes.draw do

  resources :artists do
    resources :aliases
    resources :songs, :except => :index do
      resources :aliases
    end
  end

  resources :themes do
    resources :tracks
  end
  
  resources :songs do
    resources :aliases
  end
  
  root :to => 'themes#index'
end

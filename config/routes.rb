MusicQuiz::Application.routes.draw do

  resources :artists do
    resources :songs
  end

  resources :themes do
    resources :tracks
  end
  
  root :to => 'themes#index'
end

MusicQuiz::Application.routes.draw do
  
  get "pages/index"
  
  resource :messages, :only => [:create]
  
  resource :canvas, :only => [:show, :create]
  
  resource :users, :only => :new do
    get :callback, :to => :create
  end

  resources :challenges, :only => [:index]

  resources :artists do
    member do
        get 'check'
    end
    resources :aliases
  end
  
  resources :songs do
    member do
        get 'check'
      end
    resources :aliases
  end

  resources :themes do
    resources :tracks
    resources :challenges, :only => [:show, :new, :create]
  end
  
  root :to => 'pages#index'
end

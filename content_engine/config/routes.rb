ContentEngine::Engine.routes.draw do
  resources :filetags
  resources :products
  get 'images/filter/' => 'images#filter'
  resources :images ,param: :filename do
    member do
      get 'imageonly',to: 'images#imageonly'
    end
  end
  
end

ReturnEngine::Engine.routes.draw do
  resources :statuses
  resources :inputpeople
  resources :deliverytraders
  get 'returnlogs/filter' => 'returnlogs#filter'

  resources :returnbooks
  resources :returnlogs
end

InspectorEngine::Engine.routes.draw do

  get 'forms/inspectionstandard' => 'inspectionstandard#main'
  resources :criterions
  resources :confirms
  resources :judges
  resources :packages
  resources :needles
  resources :inspections
end

Rails.application.routes.draw do
  
  devise_for :users

  root to: "products#filter"
  get 'products/filter' => 'products#filter'
  get 'products/barcode' => 'products#barcode'

  get '/new_products/filter', to: 'new_products#filter'

  get '/customers/filter', to: 'customers#filter'

  #stockのルーティング
  get '/stocks/byitem', to: 'stocks#by_item'
  get '/stocks/download', to: 'stocks#download'
  get '/stocks/download/csv', to: 'stocks#csv'

  # http://localhost:3000/products/AKAL0001　のようなURLでアクセスさせるため、paramを指定する
  resources :products, param: :code

  # http://localhost:3000/contents/images でアクセス可能にする
  mount ContentEngine::Engine, at: '/contents', as: 'contents'
  
  # http://localhost:3000/inspections/*** でアクセス可能にする
  mount InspectorEngine::Engine, at: '/inspector', as: 'inspector'

  # http://localhost:3000/returns/*** でアクセス可能にする
  mount ReturnEngine::Engine, at: '/returns', as: 'returns'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

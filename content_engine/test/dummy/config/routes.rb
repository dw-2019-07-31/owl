Rails.application.routes.draw do
  mount ContentEngine::Engine => "/content_engine"
end

Rails.application.routes.draw do
  mount InspectorEngine::Engine => "/inspector_engine"
end

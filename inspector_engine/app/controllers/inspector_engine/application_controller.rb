module InspectorEngine
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    #web-api経由でデータ作成に対応するため、createメソッドだけCSRF対策をしない。
    protect_from_forgery except: :create
  end
end

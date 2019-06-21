require_dependency "inspector_engine/application_controller"

module InspectorEngine
  class InspectionstandardController < ::ApplicationController
    
    @@rrrapiserver = "rrrapi.dad-way.local"
    @@port = 80

    before_action :set_confirm, only: [:show, :edit, :update, :destroy]

    def main
      @hincd = params[:hincd]
      if @hincd.present?
        @hinmta = JSON.parse(
          Net::HTTP.get(@@rrrapiserver, "/hinmta/#{@hincd}", @@port)
        )
        #品目名
        @hinnm = @hinmta[0]['hinnma'].strip
        #ステータス
        @hinstscd = @hinmta[0]['hinstscd'].strip
        #ブランド名
        @clsnm = @hinmta[0]['clsnm'].strip
        #メーカ製品名
        @hinenma = @hinmta[0]['hinenma'].strip

        #接頭辞２文字
        unless @hincd.blank?
          @hinprefix = @hincd.slice(0,2)
        end

        #対象年齢 target_age　原産国 country_origin　材質 material　メーカ品番 maker_code 
        @product = Product.all.where(code: @hincd)
        @criterions = Criterion.all.where(item_type: @hinprefix)
      end
      render :file => "/inspector_engine/forms/inspection_standard"
    end

  end
end

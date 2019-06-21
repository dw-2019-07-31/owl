require 'json'
require 'net/http'
require 'uri'
require 'csv'

class StocksController < ApplicationController

  @@rrrapiserver = "rrrapi.dad-way.local"
  @@port = 80

  before_action :set_stock, only: [:show, :edit, :update, :destroy]

  #Productsへのアクセスにはログインが必要とする
  before_action :authenticate_user!
  #ロールを確認し、権限のないロールに所属するユーザにはアクセスを禁止
  before_action :chk_ability

  def chk_ability
    if !(request.path_info == root_path) then
      if !(can? :read, :Product)
        redirect_to root_path , alert: '権限がありません。'
      end
    end
  end

  def by_item
    flash[:error] = nil
    @hincd = params[:hincd]

    if @hincd.blank?
      flash[:error] = "条件が未指定です。"
      render :template => "stocks/byitem" and return
    end if

    @zaiko_array = Array.new

    @hinmta = JSON.parse(
      Net::HTTP.get(@@rrrapiserver, "/hinmta/#{@hincd}", @@port)
    )
    @hinnm = @hinmta[0]['hinnma'].strip
    @hinstscd = @hinmta[0]['hinstscd'].strip
    @hinstsmta = JSON.parse(
      Net::HTTP.get(@@rrrapiserver, "/itemstatusmta/filter?clsid=#{@hinstscd}")
    )
    @hinstsnm = @hinstsmta[0]['clsnm'].strip
    
    #倉庫の一覧を取得する。
    warehouses = Array.new
    result = JSON.parse(
      Net::HTTP.get(@@rrrapiserver, "/soumta", @@port)
    )
    result.each{|r| warehouses.push([r['soucd'].strip, r['sounm'].strip]) }
    warehouses.sort!
    
    #対象品目を倉庫ごとに、各種在庫を取得していく。
    warehouses.each do |warehouse|
      soucd = warehouse[0]
      sounm = warehouse[1]

      @zaiko = JSON.parse(
        Net::HTTP.get(
          @@rrrapiserver, "/stock/aggregate?hincd=#{@hincd}&soucd=#{soucd}&outsoucd=#{soucd}", @@port
        )
      )

      @free = @zaiko["free_stock"]
      @free_sum = @zaiko["free_sum"]
      @jdntrb_sum = @zaiko["jdntrb_sum"]
      @sethin_sum = @zaiko["sethin_sum"]
      next if @free == 0 && @free_sum == 0 && @jdntrb_sum == 0 && @sethin_sum == 0

      #取得した在庫数を新しいクラスのインスタンスに設定
      zaiko = Zaiko.new()
      zaiko.soucd = soucd
      zaiko.sounm = sounm
      
      zaiko.free_sum = @free_sum
      zaiko.jdntrb_sum = @jdntrb_sum
      zaiko.sethin_sum = @sethin_sum      
      zaiko.free = @free

      #クラスインスタンスを配列に入れる
      @zaiko_array.push(zaiko) 
    end

    render :template => "stocks/byitem"
  end

  def download
    render :template => "stocks/download"
  end

  def csv
    p params
    p params["prefix"]
    flash[:error] = nil
    @data = Array.new
    @data.push(["商品コード,商品名,JAN,ステータス,上代,ブランドコード,ブランド名,倉庫コード,倉庫名,現在庫数,受注引当数,セット品引当数,フリー在庫数"])

    #ブランドコード
    @hinclbids = params[:hinclbid]
    #倉庫コード
    @soucds = params[:soucd]
    
    if @hinclbids.blank? || @soucds.blank?
      flash[:error] = "条件が未指定です。"
      render :template => "stocks/download" and return
    end

    @hinclbids.each do |hinclbid|

      #配列の初期化
      hincd_list = Array.new
      product_list_by_brand = Array.new

      #ブランド別商品情報取得
      product_list = JSON.parse(
        Net::HTTP.get(
          @@rrrapiserver, "/hinmta/filter?hinclbid=#{hinclbid}&row_limit=10000000&&select=hincd", @@port
        )
      )
      
      #品目別のループ
      product_list.each do |product|
        
        hincd = product['hincd'].strip!

        #倉庫別のループ
        @soucds.each do |soucd|

          soucd.strip!

          #在庫集計
          #セット品引当数の倉庫コードは"outsoucd"だよ。querystringに含めないとうまく在庫数が取れない。
          @zaiko = JSON.parse(
            Net::HTTP.get(
              @@rrrapiserver, "/stock/aggregate?hincd=#{hincd}&soucd=#{soucd}&outsoucd=#{soucd}", @@port
            )
          )

          @free = @zaiko["free_stock"]
          @free_sum = @zaiko["free_sum"]
          @jdntrb_sum = @zaiko["jdntrb_sum"]
          @sethin_sum = @zaiko["sethin_sum"]
          unless params["except"].nil?
            next if @free == 0 && @free_sum == 0 && @jdntrb_sum == 0 && @sethin_sum == 0
          end

          #商品情報取得
          product_info = JSON.parse(
            Net::HTTP.get(
              @@rrrapiserver, "/hinmta/filter?hincd=#{hincd}", @@port
            )
          )

          #商品名
          @hinnma = product_info[0]['hinnma'].strip!

          #JAN
          @hinjancd = product_info[0]["jsjancd"].strip!

          #ステータス
          @hinstscd = product_info[0]['hinstscd'].strip!

          #上代? numberなので、stripしないこと。
          @prctk = product_info[0]['prctk']

          #ブランド名
          @clsnm = product_info[0]['clsnm'].strip!

          #倉庫名
          sounm = JSON.parse(
            Net::HTTP.get(
              @@rrrapiserver, "/soumta/filter?soucd=#{soucd}", @@port
            )
          )
          @sounm = sounm[0]["sounm"].strip!

          soucd = 'S' + soucd unless params["prefix"].nil?

          @data.push([hincd,@hinnma,@hinjancd,@hinstscd,@prctk,hinclbid,@clsnm,soucd,@sounm,@free_sum,@jdntrb_sum,@sethin_sum,@free])
        end
        
      end
      
    end

    #@dataをCSV形式(sjis)に変換
    csv_format = CSV.generate(encoding: Encoding::SJIS, row_sep: "\r\n", force_quotes: true) { |csv|
      @data.each{|e|
        csv << e
      }
    }
    csv_format.gsub!(/"/,"")
    
    send_data(csv_format, filename: 'stock_data.csv',  type: 'text/csv; charset=shift_jis')
  end

  # GET /stocks
  # GET /stocks.json
  def index
    @stocks = Stock.all
  end

  # GET /stocks/1
  # GET /stocks/1.json
  def show
  end

  # GET /stocks/new
  def new
    @stock = Stock.new
  end

  # GET /stocks/1/edit
  def edit
  end

  # POST /stocks
  # POST /stocks.json
  def create
    @stock = Stock.new(stock_params)

    respond_to do |format|
      if @stock.save
        format.html { redirect_to @stock, notice: 'Stock was successfully created.' }
        format.json { render :show, status: :created, location: @stock }
      else
        format.html { render :new }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stocks/1
  # PATCH/PUT /stocks/1.json
  def update
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to @stock, notice: 'Stock was successfully updated.' }
        format.json { render :show, status: :ok, location: @stock }
      else
        format.html { render :edit }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1
  # DELETE /stocks/1.json
  def destroy
    @stock.destroy
    respond_to do |format|
      format.html { redirect_to stocks_url, notice: 'Stock was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_params
      params.fetch(:stock, {})
    end
end


#SouStockInfo用クラス
class Zaiko
  def initialize(name="")
    @soucd = name
    @sounm = name
    @free_sum = name
    @jdntrb_sum = name
    @sethin_sum = name
    @free = name
  end
  
  attr_accessor :soucd, :sounm, :free_sum, :jdntrb_sum, :sethin_sum, :free
end

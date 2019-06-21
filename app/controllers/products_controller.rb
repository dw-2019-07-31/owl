require 'json'
require 'net/http'
require 'uri'

class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  #before_action :set_product, only: [:show, :edit, :destroy]
  protect_from_forgery :except => [:new]

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

  # GET /products
  # GET /products.json
  def index

    @products = Product.all.paginate(page: params[:page], per_page: 100)
    
    # @products.each{|p|
    #   json = Net::HTTP.get('192.168.151.120', "/hinjancd/#{p.code}", 3000)
    #   result = JSON.parse(json)
    #   p.jan = result[0]["jsjancd"] unless result.blank?
    # }

  end
  
  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(code: @product.code), notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: product_url(code: @product.code) }
      else
        format.html { render :new }
        format.json { render json: product_url(code: @product.code).errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    logger.debug params
    @product = Product.find_by(code: params[:product][:code])
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(code: @product.code), notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: product_url(code: @product.code) }
      else
        format.html { render :edit }
        format.json { render json: product_url(code: @product.code).errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def filter
    p = request.query_parameters
    p.delete("utf8")
    p.delete("commit")

    flash[:error] = nil
    
    if p.values.reject{|v| v == ""}.count == 0 then
      flash[:error] = "検索条件に何か入力してください。"
      @products = Product.none().paginate(page: 1, per_page: 1)
    else
      @products = Product.all.paginate(page: params[:page], per_page: 100)
      
      @products = @products.where("code like ?", "%#{params[:code]}%") unless params[:code].blank?
      @products = @products.where("catchcopy like ?", "%#{params[:catchcopy]}%") unless params[:catchcopy].blank?
      @products = @products.where("weight_g like ?", "%#{params[:weight_g]}%") unless params[:weight_g].blank?

      # rrrapi から各種パラメータを取得
      %w{ hinnma hinnmb hinclbid jsjancd hinstscd }.each{|word|
        unless params[word].blank?
          c = []
          params[word] = params[word].join(' ') if params[word].is_a?(Array)
          table_name = resolve_table_name(word)
          encoded_param = URI.encode(params[word])
          result = JSON.parse(
            Net::HTTP.get(
              'rrrapi.dad-way.local',
              "/#{table_name}/filter?#{word}=#{encoded_param}&row_limit=10000000",
              80
            )
          )
          result.each{|r| c.push(r['hincd'].strip) }
          @products = @products.where(code: c)
        end
      }
    
      #リクエストされたURLがbarcodeの場合、barcode用のレイアウトをrenderする
      if request.path == "products/barcode"
        render :layout => "barcode"
      end
    end
  end

  def barcode
    filter
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      # @product = Product.find(params[:id])
      # @product = Product.find_by(code: params[:id])
      # http://localhost:3000/products/AKAL0001 のようなURLでアクセスさせる
      @product = Product.find_by(code: params[:code])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:code,:maker_code,:genre_code,:change_note,:sch_release_date,:size,:package_size,:weight_g,:package_weight,:size_note,:battery,:catchcopy,:catchcopy_long,:catchcopy_sub1,:catchcopy_sub2,:catchcopy_sub3,:discription,:usage,:care,:detailed_description,:caution,:description_path1,:description_path2,:target_age,:accessories,:manufacture,:material,:country_origin,:inner_carton,:outer_carton,:outer_size,:outer_weight,:cataloged,:catalog_copy,:kana)
    end

    def resolve_table_name(column_name)
      case column_name
      when
        'hinnma',
        'hinnmb',
        'hinclbid',
        'hinstscd'
          table_name = 'hinmta'
      when
        'jsjancd'
          table_name = 'hinjancd'
      end
      return table_name
    end
end

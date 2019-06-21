require 'will_paginate/array'

class NewProductsController < ApplicationController

  @@lisapiserver = "lisapi.dad-way.local"
  @@port = 80

  before_action :set_new_product, only: [:show, :edit, :update, :destroy]

  # GET /new_products
  # GET /new_products.json
  def index
    render :template  => "new_products/filter"
  end

  def filter
    @new_products = []
    @serch_targets = nil
    p = request.query_parameters
    p.delete("utf8")
    p.delete("commit")

    flash[:error] = nil
    
    if p.values.reject{|v| v == ""}.count == 0 then
      flash[:error] = "検索条件に何か入力してください。"
    else
      # lisapi から各種パラメータを取得
      %w{ status brand_name contact_person_at_ott tentative_item_name }.each{|word|
        unless params[word].blank?
          @serch_targets << "&" unless @serch_targets.nil?
          @serch_targets = "?" if @serch_targets.nil?
          params[word] = params[word].join(' ') if params[word].is_a?(Array)
          encoded_param = URI.encode(params[word])
          @serch_targets << "#{word}=#{encoded_param}"
        end
      }
      @new_products = JSON.parse(
        Net::HTTP.get(
          "#{@@lisapiserver}",
          "/mst_newitem/progress#{@serch_targets}&row_limit=10000000",
          "#{@@port}"
        )
      )
      @new_products = @new_products.paginate(page: params[:page], per_page: 100) unless @new_products.nil?
      
    end
  end

  # GET /new_products/1
  # GET /new_products/1.json
  def show
  end

  # PATCH/PUT /new_products/1
  # PATCH/PUT /new_products/1.json
  def update
    respond_to do |format|
      if @new_product.update(new_product_params)
        format.html { redirect_to @new_product, notice: 'New product was successfully updated.' }
        format.json { render :show, status: :ok, location: @new_product }
      else
        format.html { render :edit }
        format.json { render json: @new_product.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_new_product
      @new_product = NewProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def new_product_params
      params.fetch(:new_product, {})
    end
end

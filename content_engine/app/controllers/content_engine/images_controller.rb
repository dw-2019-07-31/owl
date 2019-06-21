require_dependency "content_engine/application_controller"

module ContentEngine
  class ImagesController < ::ApplicationController
    before_action :set_image, only: [:show, :edit, :update]
    before_action :set_owl_url

    protect_from_forgery :except => [:create]
    #protect_from_forgery with: :null_session

    def set_owl_url
      if request.ssl? then
        @@owl_url = "https://owl.dadway.com/"
      else
        @@owl_url = "http://owl.dad-way.local/"
      end
    end

    # GET /images
    # GET /images.json
    def index
      @images = Image.all.paginate(page: params[:page], per_page: 100)
    end
  
    # GET /images/1
    # GET /images/1.json
    def show
      @tagarray = []
      tags = Filetag.where(filename: @image.filename)
      tags.each {|tag|
        @tagarray.push(tag.tag)
      }
      @tagtext = @tagarray.join(',')
    end
  
    # GET /images/new
    def new
      @image = Image.new
    end 
  
    # GET /images/1/edit
    def edit
      @tagarray = []
      tags = Filetag.where(filename: @image.filename)
      tags.each {|tag|
        @tagarray.push(tag.tag)
      }
      @tagtext = @tagarray.join(',')
    end
  
    # POST /images  
    # POST /images.json
    def create
      @image = Image.new(image_params)
      if params[:image][:upload_file].blank? then
        flash[:error] = "ファイルが指定されていません"
        render :action => :new and return
      end
      if params[:image][:code].blank? then
        flash[:error] = "品番が指定されていません"
      end

      origin_filename = params[:image][:upload_file].original_filename
      @image.extension = File.extname(origin_filename)
      @image.filename = origin_filename.gsub(@image.extension,'')
      @image.imagefile = params[:image][:upload_file].read

      #クエリストリングのファイルのタグをカンマ区切りで取得する
      @tags = params[:filetag][:tags].split(",")

      logger.debug image_params
      Image.transaction do
        respond_to do |format|
          if @image.save!
            #画像を保存できたら、続けてタグ情報を順番に保存する。
            save_tags(@tags, @image.filename)
            format.html { redirect_to @image, notice: 'Image was successfully created.' }
            format.json { render :show, status: :created, location: @image }
          else
            format.html { render :new }
            format.json { render json: @image.errors, status: :unprocessable_entity }
          end
        end
      end
    end
    
    # PATCH/PUT /images/1
    # PATCH/PUT /images/1.json
    def update
      @code = params[:image][:code]
      @tags = params[:filetag][:tags].split(",")
      logger.debug image_params
  
      Image.transaction do
        respond_to do |format|
          if params[:image][:upload_file] != nil
            origin_filename = params[:image][:upload_file].original_filename
            extension = File.extname(origin_filename)
            @filename = origin_filename.gsub(extension,'')
            imagefile = params[:image][:upload_file].read
            if @image.update!(:code => @code, :filename => @filename, :extension => extension, :imagefile => imagefile)
              @result = 0
            else
              @result = 1
            end
          else
            @filename = @image.filename
            if @image.update!(:code => @code)
              @result = 0
            else
              @result = 1
            end
          end

          if @result == 0 then
            save_tags(@tags, @filename)
            format.html { redirect_to @image, notice: 'Image was successfully updated.' }
            format.json { render :show, status: :ok, location: @image }
          elsif @result == 1 then
            format.html { render :edit }
            format.json { render json: @image.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  
    def save_tags(tags,filename)
      if tags.present? && filename.present? then
        tags.each do |tag|
          filetag = Filetag.new
          filetag.filename = filename
          filetag.tag = tag
          filetag.save!
        end
      end
    end

    # DELETE /images/1
    # DELETE /images/1.json
    def destroy
      @image = Image.find_by(filename: params[:filename])
      @image.destroy
      respond_to do |format|
        format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  
    def imageonly
      logger.debug 'it imageonly'
      logger.debug params[:filename]
      @image = Image.find_by(filename: params[:filename])
      send_data @image.imagefile, filename: @image.filename + @image.extension, :disposition => 'attachment'
    end

    def filter
      #品番、タグどちらの検索にも対応する
      urls = Array.new
      
      unless params[:code].blank?
        @images = Image.where('code LIKE ?', "%#{params[:code]}%") 
        @images.each{|image|
          url = @@owl_url + 'contents/images/' + image.filename + '/imageonly'
          urls.push({'code' => "#{image.code}", 'url' => "#{url}"})
        }
      end

      unless params[:tag].blank?
        @filetags = Filetag.all
        @filetags = @filetags.where(tag: [params[:tag].split(',')])
        @filetags = @filetags.where(filename: params[:filename]) unless params[:filename].blank?
        @filenames = @filetags.pluck(:filename).uniq
        @images = Image.where(filename: [@filenames])

        @images.each{|image|
          url = @@owl_url + 'contents/images/' + image.filename + '/imageonly'
          urls.push({'code' => "#{image.code}", 'url' => "#{url}"})
        }
      end

      render json: urls
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find_by(filename: params[:filename])
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:code, :filename, :imagefile)
    end

    def filetag_params
      params.require(:filetag).permit(:filename, :tag)
    end

  end
  
end

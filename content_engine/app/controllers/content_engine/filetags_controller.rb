require_dependency "content_engine/application_controller"

module ContentEngine
  class FiletagsController < ::ApplicationController
    before_action :set_filetag, only: [:show, :edit, :update, :destroy]

    # GET /filetags
    def index
      @filetags = Filetag.all
    end

    # GET /filetags/1
    def show
    end

    # GET /filetags/new
    def new
      @filetag = Filetag.new
    end

    # GET /filetags/1/edit
    def edit
    end

    # POST /filetags
    def create
      @filetag = Filetag.new(filetag_params)

      if @filetag.save
        redirect_to @filetag, notice: 'Filetag was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /filetags/1
    def update
      if @filetag.update(filetag_params)
        redirect_to @filetag, notice: 'Filetag was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /filetags/1
    def destroy
      @filetag.destroy
      redirect_to filetags_url, notice: 'Filetag was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_filetag
        @filetag = Filetag.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def filetag_params
        params.require(:filetag).permit(:filename, :tag)
      end
  end
end

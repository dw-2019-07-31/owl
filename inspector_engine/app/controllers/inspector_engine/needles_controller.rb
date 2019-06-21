require_dependency "inspector_engine/application_controller"

module InspectorEngine
  class NeedlesController < ::ApplicationController
    before_action :set_needle, only: [:show, :edit, :update, :destroy]

    # GET /needles
    def index
      @needles = Needle.all
    end

    # GET /needles/1
    def show
    end

    # GET /needles/new
    def new
      @needle = Needle.new
    end

    # GET /needles/1/edit
    def edit
    end

    # POST /needles
    def create
      @needle = Needle.new(needle_params)

      if @needle.save
        redirect_to @needle, notice: 'Needle was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /needles/1
    def update
      if @needle.update(needle_params)
        redirect_to @needle, notice: 'Needle was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /needles/1
    def destroy
      @needle.destroy
      redirect_to needles_url, notice: 'Needle was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_needle
        @needle = Needle.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def needle_params
        params.require(:needle).permit(:houhou, :houhou_eng, :basho, :basho_eng, :cost)
      end
  end
end

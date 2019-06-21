require_dependency "inspector_engine/application_controller"

module InspectorEngine
  class CriterionsController < ::ApplicationController
    before_action :set_criterion, only: [:show, :edit, :update, :destroy]

    # GET /criterions
    def index
      @criterions = Criterion.all
    end

    # GET /criterions/1
    def show
    end

    # GET /criterions/new
    def new
      @criterion = Criterion.new
    end

    # GET /criterions/1/edit
    def edit
    end

    # POST /criterions
    def create
      @criterion = Criterion.new(criterion_params)

      if @criterion.save
        redirect_to @criterion, notice: 'Criterion was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /criterions/1
    def update
      if @criterion.update(criterion_params)
        redirect_to @criterion, notice: 'Criterion was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /criterions/1
    def destroy
      @criterion.destroy
      redirect_to criterions_url, notice: 'Criterion was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_criterion
        @criterion = Criterion.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def criterion_params
        params.require(:criterion).permit(:item_type, :kijun, :houhou, :kijun_eng, :houhou_eng)
      end
  end
end

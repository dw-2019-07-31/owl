require_dependency "return_engine/application_controller"

module ReturnEngine
  class DeliverytradersController < ::ApplicationController
    before_action :set_deliverytrader, only: [:show, :edit, :update, :destroy]

    # GET /deliverytraders
    def index
      @deliverytraders = Deliverytrader.all
    end

    # GET /deliverytraders/1
    def show
    end

    # GET /deliverytraders/new
    def new
      @deliverytrader = Deliverytrader.new
    end

    # GET /deliverytraders/1/edit
    def edit
    end

    # POST /deliverytraders
    def create
      @deliverytrader = Deliverytrader.new(deliverytrader_params)

      if @deliverytrader.save
        redirect_to @deliverytrader, notice: 'Deliverytrader was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /deliverytraders/1
    def update
      if @deliverytrader.update(deliverytrader_params)
        redirect_to @deliverytrader, notice: 'Deliverytrader was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /deliverytraders/1
    def destroy
      @deliverytrader.destroy
      redirect_to deliverytraders_url, notice: 'Deliverytrader was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_deliverytrader
        @deliverytrader = Deliverytrader.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def deliverytrader_params
        params.require(:deliverytrader).permit(:name)
      end
  end
end

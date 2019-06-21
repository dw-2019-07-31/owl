require_dependency "return_engine/application_controller"

module ReturnEngine
  class ReturnbooksController < ::ApplicationController
    before_action :set_returnbook, only: [:show, :edit, :update, :destroy]

    # GET /returnbooks
    def index
      @returnbooks = Returnbook.all
    end

    # GET /returnbooks/1
    def show
    end

    # GET /returnbooks/new
    def new
      @returnbook = Returnbook.new
    end

    # GET /returnbooks/1/edit
    def edit
    end

    # POST /returnbooks
    def create
      @returnbook = Returnbook.new(returnbook_params)

      if @returnbook.save
        redirect_to @returnbook, notice: 'Returnbook was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /returnbooks/1
    def update
      if @returnbook.update(returnbook_params)
        redirect_to @returnbook, notice: 'Returnbook was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /returnbooks/1
    def destroy
      @returnbook.destroy
      redirect_to returnbooks_url, notice: 'Returnbook was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_returnbook
        @returnbook = Returnbook.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def returnbook_params
        params.require(:returnbook).permit(:name)
      end
  end
end

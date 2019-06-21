require_dependency "return_engine/application_controller"

module ReturnEngine
  class InputpeopleController < ::ApplicationController
    before_action :set_inputperson, only: [:show, :edit, :update, :destroy]

    # GET /inputpeople
    def index
      @inputpeople = Inputperson.all
    end

    # GET /inputpeople/1
    def show
    end

    # GET /inputpeople/new
    def new
      @inputperson = Inputperson.new
    end

    # GET /inputpeople/1/edit
    def edit
    end

    # POST /inputpeople
    def create
      @inputperson = Inputperson.new(inputperson_params)

      if @inputperson.save
        redirect_to @inputperson, notice: 'Inputperson was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /inputpeople/1
    def update
      if @inputperson.update(inputperson_params)
        redirect_to @inputperson, notice: 'Inputperson was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /inputpeople/1
    def destroy
      @inputperson.destroy
      redirect_to inputpeople_url, notice: 'Inputperson was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_inputperson
        @inputperson = Inputperson.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def inputperson_params
        params.require(:inputperson).permit(:name)
      end
  end
end

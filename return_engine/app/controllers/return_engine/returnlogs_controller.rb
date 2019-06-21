require_dependency "return_engine/application_controller"

module ReturnEngine
  class ReturnlogsController < ::ApplicationController
    before_action :set_returnlog, only: [:show, :edit, :update, :destroy]

    # GET /returnlogs
    def index
      @returnlogs = Returnlog.all
    end

    # GET /returnlogs/1
    def show
    end

    # GET /returnlogs/new
    def new
      @returnlog = Returnlog.new
      @statuses = Status.all 
      @returnbooks = Returnbook.all
      @inputpeople = Inputperson.all
      @deliverytraders = Deliverytrader.all
    end

    # GET /returnlogs/1/edit
    def edit
      @statuses = Status.all 
      @returnbooks = Returnbook.all
      @inputpeople = Inputperson.all
      @deliverytraders = Deliverytrader.all
    end

    # POST /returnlogs
    def create
      @returnlog = Returnlog.new(returnlog_params)

      if @returnlog.save
        redirect_to @returnlog, notice: 'Returnlog was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /returnlogs/1
    def update
      if @returnlog.update(returnlog_params)
        redirect_to @returnlog, notice: 'Returnlog was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /returnlogs/1
    def destroy
      @returnlog.destroy
      redirect_to returnlogs_url, notice: 'Returnlog was successfully destroyed.'
    end

    def filter
      p = request.query_parameters
      p.delete("utf8")
      p.delete("commit")
  
      flash[:error] = nil
      
      if p.values.reject{|v| v == ""}.count == 0 then
        flash[:error] = "検索条件に何か入力してください。"
        @returnlogs = Returnlog.all.paginate(page: params[:page], per_page: 100).order("id desc")
      else
        @returnlogs = Returnlog.all.paginate(page: params[:page], per_page: 100).order("id desc")
        @returnlogs = @returnlogs.where("status like ?", "%#{params[:status]}%") unless params[:status].blank?
        @returnlogs = @returnlogs.where("arrived_date like ?", "%#{params[:arrived_date]}%") unless params[:arrived_date].blank?
        @returnlogs = @returnlogs.where("owner_code like ?", "%#{params[:owner_code]}%") unless params[:owner_code].blank?
        @returnlogs = @returnlogs.where("sales_person like ?", "%#{params[:sales_person]}%") unless params[:sales_person].blank?
        @returnlogs = @returnlogs.where("owner_name like ?", "%#{params[:owner_name]}%") unless params[:owner_name].blank?
      end
    end
  

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_returnlog
        @returnlog = Returnlog.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def returnlog_params
        params.require(:returnlog).permit(:arrived_date, :delivery_trader, :owner_code, :owner_name, :cutoff_date, :sales_person, :inquiry_no, :boxes_count, :peace_count, :returned_date, :input_person, :note, :return_book, :status)
      end
  end
end

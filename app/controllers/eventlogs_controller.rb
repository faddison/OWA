class EventlogsController < ApplicationController
  # GET /eventlogs
  # GET /eventlogs.json
  def index
		@eventlogs = Eventlog.search(params[:search])
		respond_to do |format|
		  format.html # index.html.erb
		  format.csv  {	export_csv(params)}
		  format.json { render json: @eventlogs }
		  format.xls  { export_xls(params) }
		  
		end
  end

  # GET /eventlogs/1
  # GET /eventlogs/1.json
  def show
    @eventlog = Eventlog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @eventlog }
    end
  end

  # GET /eventlogs/new
  # GET /eventlogs/new.json
  def new
    @eventlog = Eventlog.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @eventlog }
    end
  end

  # GET /eventlogs/1/edit
  def edit
    @eventlog = Eventlog.find(params[:id])
  end

  # POST /eventlogs
  # POST /eventlogs.json
  def create
    @eventlog = Eventlog.new(params[:eventlog])
	@eventlog.ename = @eventlog.event.title
	@eventlog.vname = @eventlog.visitor.fname
    respond_to do |format|
      if @eventlog.save
        format.html { redirect_to @eventlog, notice: 'Eventlog was successfully created.' }
        format.json { render json: @eventlog, status: :created, location: @eventlog }
      else
        format.html { render action: "new" }
        format.json { render json: @eventlog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /eventlogs/1
  # PUT /eventlogs/1.json
  def update
    @eventlog = Eventlog.find(params[:id])

    respond_to do |format|
      if @eventlog.update_attributes(params[:eventlog])
        format.html { redirect_to @eventlog, notice: 'Eventlog was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @eventlog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /eventlogs/1
  # DELETE /eventlogs/1.json
  def destroy
    @eventlog = Eventlog.find(params[:id])
    @eventlog.destroy

    respond_to do |format|
      format.html { redirect_to eventlogs_url }
      format.json { head :no_content }
    end
  end
  def export_csv(params)
    filename = I18n.l(Time.now, :format => :short) + "- eventlogs.csv"
    content = Event.to_csv(params)
    send_data content, :filename => filename
  end
  
  def export_xls(params)
		filename = I18n.l(Time.now, :format => :short) + "- eventlogs.xls"
		content = Event.to_csv(params)
		send_data content, :filename => filename
  end
end

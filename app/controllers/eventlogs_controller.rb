class EventlogsController < ApplicationController
  # GET /eventlogs
  # GET /eventlogs.json
  def index
	if user_signed_in?
			@eventlogs = Eventlog.search(params[:search])
			respond_to do |format|
			  format.html # index.html.erb
			  format.csv  {	export_csv(params)}
			  format.json { render json: @eventlogs }
			  format.xls  { export_xls(params) }
			  
			end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # GET /eventlogs/1
  # GET /eventlogs/1.json
  def show
	if user_signed_in?
		@eventlog = Eventlog.find(params[:id])

		respond_to do |format|
		  format.html # show.html.erb
		  format.json { render json: @eventlog }
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # GET /eventlogs/new
  # GET /eventlogs/new.json
  def new
	if user_signed_in?
		@eventlog = Eventlog.new

		respond_to do |format|
		  format.html # new.html.erb
		  format.json { render json: @eventlog }
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # GET /eventlogs/1/edit
  def edit
	if user_signed_in?
		@eventlog = Eventlog.find(params[:id])
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # POST /eventlogs
  # POST /eventlogs.json
  def create
	if user_signed_in?
		@eventlog = Eventlog.new(params[:eventlog])
		@eventlog.ename = @eventlog.event.title
		@eventlog.vname = @eventlog.visitor.fname
		@eventlog.status = "not approved"
		respond_to do |format|
		  if @eventlog.save
			format.html { redirect_to @eventlog, notice: 'Eventlog was successfully created.' }
			format.json { render json: @eventlog, status: :created, location: @eventlog }
		  else
			format.html { render action: "new" }
			format.json { render json: @eventlog.errors, status: :unprocessable_entity }
		  end
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'eventlogs', :action => 'index'
	end
  end

  # PUT /eventlogs/1
  # PUT /eventlogs/1.json
  def update
	if user_signed_in?
		if current_user.role_id == 1 || current_user.role_id == 2
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
		else
			flash[:notice] = "You don't have access to do that"
			redirect_to :controller=>'eventlogs', :action => 'index'
		end
	else
		redirect_to :controller=>'home', :action => 'index'
	end
  end
  
  def approve
	if user_signed_in? &&  current_user.role_id == 1
		@eventlog = Eventlog.find(params[:id])
		@eventlog.status = 'approved'
		@eventlog.save
		Eventlog.conndeve
		@newobj = @eventlog.dup
		@newobj.save
		Eventlog.connfinal

		respond_to do |format|
		  format.html { redirect_to eventlogs_url }
		  format.json { head :no_content }
		end
	else
		flash[:notice] = "You don't have access to do that"
		if  user_signed_in?
			redirect_to :controller=>'dashboard', :action => 'index'
		else
			redirect_to :controller=>'home', :action => 'index'
		end
	end
  end

  # DELETE /eventlogs/1
  # DELETE /eventlogs/1.json
  def destroy
	if user_signed_in?
		if current_user.role_id == 1 || current_user.role_id == 2
			@eventlog = Eventlog.find(params[:id])
			@eventlog.destroy

			respond_to do |format|
			  format.html { redirect_to eventlogs_url }
			  format.json { head :no_content }
			end
		else
			flash[:notice] = "You don't have access to do that"
			redirect_to :controller=>'eventlogs', :action => 'index'
		end
	else
		redirect_to :controller=>'home', :action => 'index'
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


class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index
		if user_signed_in?
			@events = Event.search(params[:search])

			respond_to do |format|
			  format.html # index.html.erb
			  format.csv  {	export_csv(params)}
			  format.json { render json: @events }
			  format.xls  { export_xls(params) }
			end
		else
			flash[:notice] = "You don't have access to do that"
			redirect_to :controller=>'home', :action => 'index'
		end
  end

  # GET /events/1
  # GET /events/1.json
  def show
	if user_signed_in?
		@event = Event.find(params[:id])
		respond_to do |format|
		  format.html # show.html.erb
		  format.json { render json: @event }
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # GET /events/new
  # GET /events/new.json
  def new
	if user_signed_in?
		@event = Event.new

		respond_to do |format|
		  format.html # new.html.erb
		  format.json { render json: @event }
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # GET /events/1/edit
  def edit
	if user_signed_in?
		@event = Event.find(params[:id])
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # POST /events
  # POST /events.json
  def create
	if user_signed_in?
		@event = Event.new(params[:event])

		respond_to do |format|
		  if @event.save
			format.html { redirect_to @event, notice: 'Event was successfully created.' }
			format.json { render json: @event, status: :created, location: @event }
		  else
			format.html { render action: "new" }
			format.json { render json: @event.errors, status: :unprocessable_entity }
		  end
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
	if user_signed_in?
		if current_user.role_id == 1 || current_user.role_id == 2
			@event = Event.find(params[:id])	
			respond_to do |format|
			  if @event.update_attributes(params[:event])
				format.html { redirect_to @event, notice: 'Event was successfully updated.' }
				format.json { head :no_content }
			  else
				format.html { render action: "edit" }
				format.json { render json: @event.errors, status: :unprocessable_entity }
			  end
			end
		else
			flash[:notice] = "You don't have access to do that"
			redirect_to :controller=>'events', :action => 'index'
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
	if user_signed_in?
		if current_user.role_id == 1 || current_user.role_id == 2
			@event = Event.find(params[:id])
			@event.destroy

			respond_to do |format|
			  format.html { redirect_to events_url }
			  format.json { head :no_content }
			end
		else
			flash[:notice] = "You don't have access to do that"
			redirect_to :controller=>'events', :action => 'index'
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end
  
  def approve
	if user_signed_in? &&  current_user.role_id == 1
		@event = Brochurelog.find(params[:id])
		@eventstatus = 'approvaled'
		@event.save
		Event.conndeve
		@newobj = @event.dup
		@newobj.save
		Event.connfinal
		respond_to do |format|
		  format.html { redirect_to events_url }
		  format.json { head :no_content }
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'events', :action => 'index'
	end
  end
  
  def export_csv(params)
    filename = I18n.l(Time.now, :format => :short) + "- events.csv"
    content = Event.to_csv(params)
    send_data content, :filename => filename
  end
  
  def export_xls(params)
		filename = I18n.l(Time.now, :format => :short) + "- events.xls"
		content = Event.to_csv(params)
		send_data content, :filename => filename
  end
  
end
class EventtypesController < ApplicationController
  # GET /eventtypes
  # GET /eventtypes.json
  def index
	if user_signed_in?
		@eventtypes = Eventtype.search(params[:search])
		respond_to do |format|
		  format.html # index.html.erb
		  format.csv  {	export_csv(params)}
		  format.json { render json: @eventtypes }
		  format.xls  { export_xls(params) }	
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # GET /eventtypes/1
  # GET /eventtypes/1.json
  def show
	if user_signed_in?
		@eventtype = Eventtype.find(params[:id])

		respond_to do |format|
		  format.html # show.html.erb
		  format.json { render json: @eventtype }
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # GET /eventtypes/new
  # GET /eventtypes/new.json
  def new
	if user_signed_in?
		@eventtype = Eventtype.new

		respond_to do |format|
		  format.html # new.html.erb
		  format.json { render json: @eventtype }
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # GET /eventtypes/1/edit
  def edit
	if user_signed_in?
		@eventtype = Eventtype.find(params[:id])
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # POST /eventtypes
  # POST /eventtypes.json
  def create
	if user_signed_in?
		@eventtype = Eventtype.new(params[:eventtype])

		respond_to do |format|
		  if @eventtype.save
			format.html { redirect_to @eventtype, notice: 'Eventtype was successfully created.' }
			format.json { render json: @eventtype, status: :created, location: @eventtype }
		  else
			format.html { render action: "new" }
			format.json { render json: @eventtype.errors, status: :unprocessable_entity }
		  end
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # PUT /eventtypes/1
  # PUT /eventtypes/1.json
  def update
	if user_signed_in?
		if current_user.role_id == 1|| current_user.role_id == 2
			@eventtype = Eventtype.find(params[:id])

			respond_to do |format|
			  if @eventtype.update_attributes(params[:eventtype])
				format.html { redirect_to @eventtype, notice: 'Eventtype was successfully updated.' }
				format.json { head :no_content }
			  else
				format.html { render action: "edit" }
				format.json { render json: @eventtype.errors, status: :unprocessable_entity }
			  end
			end
		else
			flash[:notice] = "You don't have access to do that"
			redirect_to :controller=>'home', :action => 'index'
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # DELETE /eventtypes/1
  # DELETE /eventtypes/1.json
  def destroy
	if user_signed_in?
		if current_user.role_id == 1|| current_user.role_id == 2
			@eventtype = Eventtype.find(params[:id])
			@eventtype.destroy

			respond_to do |format|
			  format.html { redirect_to eventtypes_url }
			  format.json { head :no_content }
			end
		else
			flash[:notice] = "You don't have access to do that"
			redirect_to :controller=>'home', :action => 'index'
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end
  def export_csv(params)
    filename = I18n.l(Time.now, :format => :short) + "- eventtypes.csv"
    content = Eventtype.to_csv(params)
    send_data content, :filename => filename
  end
  
  def approve
	if user_signed_in? &&  current_user.role_id == 1
		@eventtype = Eventtype.find(params[:id])
		Eventtype.conndeve
		@newb = Eventtype.new
		@newb.name = @eventtype.name
		@newb.save
		Eventtype.connfinal
		#Brochure.connfinal
		@Eventtype.destroy

		respond_to do |format|
		  format.html { redirect_to eventtypes_url }
		  format.json { head :no_content }
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'dashboard', :action => 'index'
	end
  end
  
  
  def export_xls(params)
		filename = I18n.l(Time.now, :format => :short) + "- eventtypes.xls"
		content = Eventtype.to_csv(params)
		send_data content, :filename => filename
  end
  
end

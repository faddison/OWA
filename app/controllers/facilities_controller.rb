class FacilitiesController < ApplicationController
  # GET /facilities
  # GET /facilities.json
  def index
	if user_signed_in?
		@facilities = Facility.search(params[:search])

		respond_to do |format|
		  format.html # index.html.erb
		  format.csv  {	export_csv(params)}
		  format.json { render json: @facilities }
		  format.xls  { export_xls(params) }
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # GET /facilities/1
  # GET /facilities/1.json
  def show
	if user_signed_in?
		@facility = Facility.find(params[:id])

		respond_to do |format|
		  format.html # show.html.erb
		  format.json { render json: @facility }
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # GET /facilities/new
  # GET /facilities/new.json
  def new
	if user_signed_in?
		@facility = Facility.new

		respond_to do |format|
		  format.html # new.html.erb
		  format.json { render json: @facility }
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # GET /facilities/1/edit
  def edit
	if user_signed_in?
		@facility = Facility.find(params[:id])
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # POST /facilities
  # POST /facilities.json
  def create
	if user_signed_in?
		@facility = Facility.new(params[:facility])
		@facility.status = "not approved"
		respond_to do |format|
		  if @facility.save
			format.html { redirect_to @facility, notice: 'Facility was successfully created.' }
			format.json { render json: @facility, status: :created, location: @facility }
		  else
			format.html { render action: "new" }
			format.json { render json: @facility.errors, status: :unprocessable_entity }
		  end
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # PUT /facilities/1
  # PUT /facilities/1.json
  def update
	if  user_signed_in?
		if current_user.role_id == 1|| current_user.role_id == 2
			@facility = Facility.find(params[:id])

			respond_to do |format|
			  if @facility.update_attributes(params[:facility])
				format.html { redirect_to @facility, notice: 'Facility was successfully updated.' }
				format.json { head :no_content }
			  else
				format.html { render action: "edit" }
				format.json { render json: @facility.errors, status: :unprocessable_entity }
			  end
			end
		else
			flash[:notice] = "You don't have access to do that"
			redirect_to :controller=>'facilities', :action => 'index'
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # DELETE /facilities/1
  # DELETE /facilities/1.json
  def destroy
	if  user_signed_in?
		if current_user.role_id == 1|| current_user.role_id == 2
			@facility = Facility.find(params[:id])
			@facility.destroy

			respond_to do |format|
			  format.html { redirect_to facilities_url }
			  format.json { head :no_content }
			end
		else
			flash[:notice] = "You don't have access to do that"
			redirect_to :controller=>'facilities', :action => 'index'
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end
  
  def approve
	if user_signed_in? &&  current_user.role_id == 1
		@facility = Facility.find(params[:id])
		@facility.status = 'approved'
		@facility.save
		Facility.conndeve
		@newobj = @facility.dup
		@newobj.save
		Facility.connfinal

		respond_to do |format|
		  format.html { redirect_to facilities_url }
		  format.json { head :no_content }
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'facilities', :action => 'index'
	end
  end
  
  
  def export_csv(params)
    filename = I18n.l(Time.now, :format => :short) + "- facilities.csv"
    content = Facility.to_csv(params)
    send_data content, :filename => filename
  end
  
  def export_xls(params)
		filename = I18n.l(Time.now, :format => :short) + "- facilities.xls"
		content = Facility.to_csv(params)
		send_data content, :filename => filename
  end
  
  
  
end

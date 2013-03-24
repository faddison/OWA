class BrochuresController < ApplicationController
  # GET /brochures
  # GET /brochures.json

  def index
		if user_signed_in? 
			Brochure.connfinal
			@brochures = Brochure.search(params[:search])
			
			respond_to do |format|
				format.html # index.html.erb
				format.csv  {	export_csv(params)}
				format.json { render json: @brochures }
				format.xls  { export_xls(params) }
			end
		else
			flash[:notice] = "You don't have access to do that"
			redirect_to :controller=>'home', :action => 'index'
		end
  end

  # GET /brochures/1
  # GET /brochures/1.json
  def show
	if user_signed_in?
		@brochure = Brochure.find(params[:id])

		respond_to do |format|
		  format.html # show.html.erb
		  format.json { render json: @brochure }
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # GET /brochures/new
  # GET /brochures/new.json
  def new
	if user_signed_in?
		@brochure = Brochure.new

		respond_to do |format|
		  format.html # new.html.erb
		  format.json { render json: @brochure }
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # GET /brochures/1/edit
  def edit
	if user_signed_in?
		@brochure = Brochure.find(params[:id])
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # POST /brochures
  # POST /brochures.json
  def create
	if user_signed_in?
		@brochure = Brochure.new(params[:brochure])

		respond_to do |format|
		  if @brochure.save
			format.html { redirect_to @brochure, notice: 'Brochure was successfully created.' }
			format.json { render json: @brochure, status: :created, location: @brochure }
		  else
			format.html { render action: "new" }
			format.json { render json: @brochure.errors, status: :unprocessable_entity }
		  end
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # PUT /brochures/1
  # PUT /brochures/1.json
  def update
	if user_signed_in?
		if current_user.role_id == 1 || current_user.role_id == 2 
			@brochure = Brochure.find(params[:id])

			respond_to do |format|
			  if @brochure.update_attributes(params[:brochure])
				format.html { redirect_to @brochure, notice: 'Brochure was successfully updated.' }
				format.json { head :no_content }
			  else
				format.html { render action: "edit" }
				format.json { render json: @brochure.errors, status: :unprocessable_entity }
			  end
			end
		else
			flash[:notice] = "You don't have access to do that"
			redirect_to :controller=>'dashboard', :action => 'index'
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # DELETE /brochures/1
  # DELETE /brochures/1.json
  def destroy
	if user_signed_in?
		if current_user.role_id == 1 || current_user.role_id == 2 
			@brochure = Brochure.find(params[:id])
			@brochure.destroy
			respond_to do |format|
			  format.html { redirect_to brochures_url }
			  format.json { head :no_content }
			end
		else
			flash[:notice] = "You don't have access to do that"
			redirect_to :controller=>'dashboard', :action => 'index'
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end
  def approve
	if user_signed_in? &&  current_user.role_id == 1
		@brochure = Brochure.find(params[:id])
		Brochure.conndeve
		@newb = Brochure.new
		@newb.name = @brochure.name
		@newb.save
		Brochure.connfinal
		#Brochure.connfinal
		@brochure.destroy

		respond_to do |format|
		  format.html { redirect_to brochures_url }
		  format.json { head :no_content }
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'dashboard', :action => 'index'
	end
	#Brochure.conndeve
  end
  
  def export_csv(params)
    filename = I18n.l(Time.now, :format => :short) + "- brochures.csv"
    content = Brochure.to_csv(params)
    send_data content, :filename => filename
  end
  
  def export_xls(params)
		filename = I18n.l(Time.now, :format => :short) + "- brochures.xls"
		content = Brochure.to_csv(params)
		send_data content, :filename => filename
  end
  
end

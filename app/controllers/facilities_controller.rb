class FacilitiesController < ApplicationController
  # GET /facilities
  # GET /facilities.json
	load_and_authorize_resource
  def index
	
		@facilities = Facility.metasearch(params[:search])

		respond_to do |format|
		  format.html # index.html.erb
		  format.csv  {	export_csv(params)}
		  format.json { render json: @facilities }
		  format.xls  { export_xls(params) }
		end
	
  end

  # GET /facilities/1
  # GET /facilities/1.json
  def show
	
		@facility = Facility.find(params[:id])

		respond_to do |format|
		  format.html # show.html.erb
		  format.json { render json: @facility }
		end
	
  end

  # GET /facilities/new
  # GET /facilities/new.json
  def new
	
		@facility = Facility.new

		respond_to do |format|
		  format.html # new.html.erb
		  format.json { render json: @facility }
		end
	
  end

  # GET /facilities/1/edit
  def edit
	
		@facility = Facility.find(params[:id])
	
  end

  # POST /facilities
  # POST /facilities.json
  def create
	
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
	
  end

  # PUT /facilities/1
  # PUT /facilities/1.json
  def update
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
	
  end

  # DELETE /facilities/1
  # DELETE /facilities/1.json
  def destroy
			@facility = Facility.find(params[:id])
			@facility.destroy

			respond_to do |format|
			  format.html { redirect_to facilities_url }
			  format.json { head :no_content }
			end
	
  end
  
  def approve
		_approve(Facility.find(params[:id]))
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

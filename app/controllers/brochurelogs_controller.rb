class BrochurelogsController < ApplicationController
  # GET /brochurelogs
  # GET /brochurelogs.json 
  load_and_authorize_resource
  
  def index
	
		@search = Brochurelog.metasearch(params[:search])
		@brochurelogs = @search.paginate(:page => params[:page])
		
			respond_to do |format|
			  format.html # index.html.erb
			  format.csv  {	export_csv(params)}
			  format.json { render json: @brochurelogs }
			  format.xls  { export_xls(params) }
			end
  end

  # GET /brochurelogs/1
  # GET /brochurelogs/1.json
  def show
		@brochurelog = Brochurelog.find(params[:id])
		respond_to do |format|
		  format.html # show.html.erb
		  format.json { render json: @brochurelog }
		end
  end

  # GET /brochurelogs/new
  # GET /brochurelogs/new.json
  def new
		@brochurelog = Brochurelog.new

		respond_to do |format|
		  format.html # new.html.erb
		  format.json { render json: @brochurelog }
		end
  end

  # GET /brochurelogs/1/edit
  def edit
		@brochurelog = Brochurelog.find(params[:id])
  end

  # POST /brochurelogs
  # POST /brochurelogs.json
  def create
		@brochurelog = Brochurelog.new(params[:brochurelog])
		@brochurelog.bname = Brochure.find(@brochurelog.brochure_id).name
		@brochurelog.fname = Facility.find(@brochurelog.facility_id).name
		@brochurelog.status = 'not approved'
		respond_to do |format|
			if @brochurelog.save 
				format.html { redirect_to @brochurelog, notice: 'Brochurelog was successfully created.' }
				format.json { render json: @brochurelog, status: :created, location: @brochurelog }
		end
  end
	end

  # PUT /brochurelogs/1
  # PUT /brochurelogs/1.json
  def update
			@brochurelog = Brochurelog.find(params[:id])
			respond_to do |format|
			  if @brochurelog.update_attributes(params[:brochurelog])
				format.html { redirect_to @brochurelog, notice: 'Brochurelog was successfully updated.' }
				format.json { head :no_content }
			  else
				format.html { render action: "edit" }
				format.json { render json: @brochurelog.errors, status: :unprocessable_entity }
			  end
			end	
  end

  # DELETE /brochurelogs/1
  # DELETE /brochurelogs/1.json
  def destroy
			@brochurelog = Brochurelog.find(params[:id])
			@brochurelog.destroy
			
			respond_to do |format|
			  format.html { redirect_to brochurelogs_url }
			  format.json { head :no_content }
			end
  end
  
  def approve
		_approve(Brochurelog.find(params[:id]))
  end
  
  def export_csv(params)
    filename = I18n.l(Time.now, :format => :short) + "- brochurelogs.csv"
    content = Brochurelog.to_csv(params)
    send_data content, :filename => filename
  end
  
  def export_xls(params)
		filename = I18n.l(Time.now, :format => :short) + "- brochurelogs.xls"
		content = Brochurelog.to_csv(params)
		send_data content, :filename => filename
  end

end

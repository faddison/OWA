class BrochurelogsController < ApplicationController
  # GET /brochurelogs
  # GET /brochurelogs.json 
  
  
  def index
		if user_signed_in?
			@brochurelogs = Brochurelog.search(params[:search])
			respond_to do |format|
			  format.html # index.html.erb
			  format.csv  {	export_csv(params)}
			  format.json { render json: @brochurelogs }
			  format.xls  { export_xls(params) }
			end
		else
			redirect_to :controller=>'home', :action => 'index'
		end
	
  end

  # GET /brochurelogs/1
  # GET /brochurelogs/1.json
  def show
	if user_signed_in?
		@brochurelog = Brochurelog.find(params[:id])

		respond_to do |format|
		  format.html # show.html.erb
		  format.json { render json: @brochurelog }
		end
	else
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # GET /brochurelogs/new
  # GET /brochurelogs/new.json
  def new
	if user_signed_in?
		@brochurelog = Brochurelog.new

		respond_to do |format|
		  format.html # new.html.erb
		  format.json { render json: @brochurelog }
		end
	else
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # GET /brochurelogs/1/edit
  def edit
	if if user_signed_in?
		@brochurelog = Brochurelog.find(params[:id])
	else
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # POST /brochurelogs
  # POST /brochurelogs.json
  def create
	if user_signed_in?
		@brochurelog = Brochurelog.new(params[:brochurelog])
		@rid = @brochurelog.brochure_id
		@fid = @brochurelog.facility_id
		@d = @brochurelog.date
		@brochurelog.bname = @brochurelog.brochure.name
		@brochurelog.fname = @brochurelog.facility.name
		@check = duplicate(@rid,@fid,@d )
		respond_to do |format|
			if @check == -1 && @brochurelog.save 
				format.html { redirect_to @brochurelog, notice: 'Brochurelog was successfully created.' }
				format.json { render json: @brochurelog, status: :created, location: @brochurelog }
		  else
			@brotemp = Brochurelog.find(@check)
			@brotemp.count = @brotemp.count + @brochurelog.count
			@brotemp.save
			format.html { render action: "new" }
			format.json { render json: @brochurelog.errors, status: :unprocessable_entity }
		  end
		  
		end
	else
		redirect_to :controller=>'home', :action => 'index'
	end
	
  end

  # PUT /brochurelogs/1
  # PUT /brochurelogs/1.json
  def update
	if user_signed_in? 
		if current_user.role_id == 2 || current_usr.role_id == 1
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
		else
			redirect_to :controller=>'dashboard', :action => 'index'
		end
	else
		redirect_to :controller=>'home', :action => 'index'
	end
	
  end

  # DELETE /brochurelogs/1
  # DELETE /brochurelogs/1.json
  def destroy
	if user_signed_in? 
		if current_user.role_id == 2 || current_usr.role_id == 1
			@brochurelog = Brochurelog.find(params[:id])
			@brochurelog.destroy
			
			respond_to do |format|
			  format.html { redirect_to brochurelogs_url }
			  format.json { head :no_content }
			end
		else
			redirect_to :controller=>'dashboard', :action => 'index'
		end
	else
		redirect_to :controller=>'home', :action => 'index'
	end
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
  
  
  private
	def duplicate(temprid,tempfid,tempdate)
		Brochurelog.all.each do |bro|
			if temprid == bro.brochure_id && tempfid == bro.facility_id && tempdate == bro.date
				return bro.id
			end
		end
		return -1
	end
end
end
end
class ReferrallogsController < ApplicationController
  # GET /referrallogs
  # GET /referrallogs.json
	load_and_authorize_resource
  def index
		
			@referrallogs = Referrallog.metasearch(params[:search])

			respond_to do |format|
			  format.html # index.html.erb
			  format.csv  {	export_csv(params)}
			  format.json { render json: @referrallogs }
			  format.xls  { export_xls(params) }
			end
  end

  # GET /referrallogs/1
  # GET /referrallogs/1.json
  def show
	
		@referrallog = Referrallog.find(params[:id])

		respond_to do |format|
		  format.html # show.html.erb
		  format.json { render json: @referrallog }
		end
	
  end

  # GET /referrallogs/new
  # GET /referrallogs/new.json
  def new
	
		@referrallog = Referrallog.new

		respond_to do |format|
		  format.html # new.html.erb
		  format.json { render json: @referrallog }
		end
	
  end

  # GET /referrallogs/1/edit
  def edit
	
		@referrallog = Referrallog.find(params[:id])
	
  end

  # POST /referrallogs
  # POST /referrallogs.json
  def create
	
		@referrallog = Referrallog.new(params[:referrallog])
		@referrallog.status = "not approved"
		@rid = @referrallog.referral_id
		@fid = @referrallog.facility_id
		@d = @referrallog.date
		@referrallog.fname = @referrallog.referral.name
		@referrallog.rname = @referrallog.facility.name
		@check = duplicate(@rid,@fid,@d )
		respond_to do |format|
			if @check == -1 && @referrallog.save
				format.html { redirect_to @referrallog, notice: 'Referrallog was successfully created.' }
				format.json { render json: @referrallog, status: :created, location: @referrallog }
			else
				@reftemp = Referrallog.find(@check)
				@reftemp.count = @reftemp.count + @referrallog.count
				@reftemp.save
				format.html { redirect_to @referrallog, notice: 'Referrallog was not successfully created.' }
			end
		end
	
  end

  # PUT /referrallogs/1
  # PUT /referrallogs/1.json
  def update
	
		
			@referrallog = Referrallog.find(params[:id])

			respond_to do |format|
			  if @referrallog.update_attributes(params[:referrallog])
				format.html { redirect_to @referrallog, notice: 'Referrallog was successfully updated.' }
				format.json { head :no_content }
			  else
				format.html { render action: "edit" }
				format.json { render json: @referrallog.errors, status: :unprocessable_entity }
			  end
			end
		
	
	
  end

  # DELETE /referrallogs/1
  # DELETE /referrallogs/1.json
  def destroy
	
		
			@referrallog = Referrallog.find(params[:id])
			@referrallog.destroy

			respond_to do |format|
			  format.html { redirect_to referrallogs_url }
			  format.json { head :no_content }
			end
	
  end
  
  def approve
		_approve(Referrallog.find(params[:id]))
	end
  
  def export_csv(params)
    filename = I18n.l(Time.now, :format => :short) + "- referrallogs.csv"
    content = Referrallog.to_csv(params)
    send_data content, :filename => filename
  end
  
  def export_xls(params)
		filename = I18n.l(Time.now, :format => :short) + "- referrallogs.xls"
		content = Referrallog.to_csv(params)
		send_data content, :filename => filename
  end
  
  end
  
  

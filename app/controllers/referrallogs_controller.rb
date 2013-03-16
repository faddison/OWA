class ReferrallogsController < ApplicationController
  # GET /referrallogs
  # GET /referrallogs.json
  def index
    @referrallogs = Referrallog.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @referrallogs }
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

    respond_to do |format|
		if	@referrallog.referral.rlogid == nil && @referrallog.facility.rlogid == nil
		  if @referrallog.save
			format.html { redirect_to @referrallog, notice: 'Referrallog was successfully created.' }
			format.json { render json: @referrallog, status: :created, location: @referrallog }
			@referrallog.referral.rlogid = @referrallog.referral_id
			@referrallog.referral.save
			@referrallog.facility.rlogid = @referrallog.facility_id
			@referrallog.facility.save
		  else
			format.html { render action: "new" }
			format.json { render json: @referrallog.errors, status: :unprocessable_entity }
		  end
		else
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
		@referrallog.referral.rlogid = @referrallog.referral_id
		@referrallog.referral.save
		@referrallog.facility.rlogid = @referrallog.facility_id
		@referrallog.facility.save
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
	@referrallog.referral.rlogid = nil
	@referrallog.referral.save
	@referrallog.facility.rlogid = nil
	@referrallog.facility.save
    @referrallog.destroy

    respond_to do |format|
      format.html { redirect_to referrallogs_url }
      format.json { head :no_content }
    end
  end
end

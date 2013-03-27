class ReferralsController < ApplicationController
  # GET /referrals
  # GET /referrals.json
  def index
		Referral.connfinal
		if user_signed_in?
			@referrals = Referral.search(params[:search])

			respond_to do |format|
			  format.html # index.html.erb
			  format.csv  {	export_csv(params)}
			  format.json { render json: @referrals }
			  format.xls  { export_xls(params) }
			end
		else
			flash[:notice] = "You don't have access to do that"
			redirect_to :controller=>'home', :action => 'index'
		end
  end

  # GET /referrals/1
  # GET /referrals/1.json
  def show
	if user_signed_in?
		@referral = Referral.find(params[:id])

		respond_to do |format|
		  format.html # show.html.erb
		  format.json { render json: @referral }
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # GET /referrals/new
  # GET /referrals/new.json
  def new
	if user_signed_in?
		@referral = Referral.new

		respond_to do |format|
		  format.html # new.html.erb
		  format.json { render json: @referral }
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # GET /referrals/1/edit
  def edit
	if user_signed_in?
		@referral = Referral.find(params[:id])
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # POST /referrals
  # POST /referrals.json
  def create
	if user_signed_in?
		@referral = Referral.new(params[:referral])
		@referral.status = "not approved"
		respond_to do |format|
		  if @referral.save
			format.html { redirect_to @referral, notice: 'Referral was successfully created.' }
			format.json { render json: @referral, status: :created, location: @referral }
		  else
			format.html { render action: "new" }
			format.json { render json: @referral.errors, status: :unprocessable_entity }
		  end
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # PUT /referrals/1
  # PUT /referrals/1.json
  def update
	if user_signed_in?
		if current_user.role_id == 1 || current_user.role_id == 2
			@referral = Referral.find(params[:id])

			respond_to do |format|
			  if @referral.update_attributes(params[:referral])
				format.html { redirect_to @referral, notice: 'Referral was successfully updated.' }
				format.json { head :no_content }
			  else
				format.html { render action: "edit" }
				format.json { render json: @referral.errors, status: :unprocessable_entity }
			  end
			end
		else
			flash[:notice] = "You don't have access to do that"
			redirect_to :controller=>'referrals', :action => 'index'
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # DELETE /referrals/1
  # DELETE /referrals/1.json
  def destroy
	if user_signed_in?
		if current_user.role_id == 1 || current_user.role_id == 2
			@referral = Referral.find(params[:id])
			@referral.destroy

			respond_to do |format|
			  format.html { redirect_to referrals_url }
			  format.json { head :no_content }
			end
		else
			redirect_to :controller=>'referrals', :action => 'index'
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'home', :action => 'index'
	end
  end
  def approve
	if user_signed_in? &&  current_user.role_id == 1
		@referral = Referral.find(params[:id])
		@referral.status = 'approved'
		@referral.save
		Referral.conndeve
		@newobj = @referral.dup
		@newobj.save
		Referral.connfinal

		respond_to do |format|
		  format.html { redirect_to referrals_url }
		  format.json { head :no_content }
		end
	else
		flash[:notice] = "You don't have access to do that"
		redirect_to :controller=>'referrals', :action => 'index'
	end
	#Brochure
  end
  
  def export_csv(params)
    filename = I18n.l(Time.now, :format => :short) + "- referrals.csv"
    content = Referral.to_csv(params)
    send_data content, :filename => filename
  end
  
  def export_xls(params)
		filename = I18n.l(Time.now, :format => :short) + "- referrals.xls"
		content = Referral.to_csv(params)
		send_data content, :filename => filename
  end
  
  
end

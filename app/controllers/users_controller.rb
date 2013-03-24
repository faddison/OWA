class UsersController < ApplicationController
	load_and_authorize_resource :only => [:show,:new,:destroy,:edit,:update]
	
	def index
		#if user_signed_in? && current_user.role_id == 1
			@users = User.search(params[:search])
			respond_to do |format|
				format.json { render :json => @users }
				format.xml  { render :xml => @users }
				format.html
				format.csv  {	export_csv(params)}
				format.xls  { export_xls(params) }
			end
		#else
			#redirect_to :controller=>'home', :action => 'index'
		#end
	end
	
	def new
		#@user = User.new
		#if user_signed_in? && current_user.role_id == 1
			respond_to do |format|
			  format.html # new.html.erb
			  format.json { render json: @user }
			end
		#else
			#redirect_to :controller=>'home', :action => 'index'
		#end

	end
	def show
	
			respond_to do |format|
			format.json { render :json => @user }
			format.xml  { render :xml => @user }
			format.html 
		end
    end
	def destroy
		#if user_signed_in? && current_user.role_id == 1
			@user.destroy
			respond_to do |format|
				#format.json { respond_to_destroy(:ajax) }
				#format.xml  { head :ok }
				#format.html { respond_to_destroy(:html) }
				format.html { redirect_to :controller=>'adminboard', :action => 'index' }
			end
		#else
			#redirect_to :controller=>'home', :action => 'index'
		#end
	end
	def create
		#if user_signed_in? && current_user.role_id == 1
			@user = User.new(params[:user])
		 
			if @user.save
					redirect_to users_url, :notice => "User created."
			else
			  respond_to do |format|
					format.json { render :text => "Could not create user", :status => :unprocessable_entity } # placeholder
					format.xml  { head :ok }
					format.html { render :action => :new, :status => :unprocessable_entity }
				end
			end
		#else
			#redirect_to :controller=>'home', :action => 'index'
		#end
	end
	def edit
		@user = User.find(params[:id])
	end
	def update
		if user_signed_in? && current_user.role_id == 1
			if params[:user][:password].blank?
			  [:password,:password_confirmation,:current_password].collect{|p| params[:user].delete(p) }
			else
			  @user.errors[:base] << "The password you entered is incorrect" unless @user.valid_password?(params[:user][:current_password])
			end
	 
			respond_to do |format|
			  if @user.errors[:base].empty? and @user.update_attributes(params[:user])
				flash[:notice] = "Your account has been updated"
				format.json { render :json => @user.to_json, :status => 200 }
				format.xml  { head :ok }
				format.html { render :action => :edit }
			  else
				format.json { render :text => "Could not update user", :status => :unprocessable_entity } #placeholder
				format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
				format.html { render :action => :edit, :status => :unprocessable_entity }
			  end
			end
		else
			redirect_to :controller=>'home', :action => 'index'
		end
	end
	def export_csv(params)
    filename = I18n.l(Time.now, :format => :short) + "- users.csv"
    content = User.to_csv(params)
    send_data content, :filename => filename
  end
  
  def export_xls(params)
		filename = I18n.l(Time.now, :format => :short) + "-users.xls"
		content = User.to_csv(params)
		send_data content, :filename => filename
  end
 
	
 end

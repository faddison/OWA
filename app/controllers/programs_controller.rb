class ProgramsController < ApplicationController
  # GET /programs
  # GET /programs.json
  def index
	if user_signed_in?
		@programs = Program.search(params[:search])

		respond_to do |format|
		 format.html # index.html.erb
		  format.csv  {	export_csv(@params)}
		  format.json { render json: @programs }
		  format.xls  { export_xls(@params) }	
		end
	else
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # GET /programs/1
  # GET /programs/1.json
  def show
	if user_signed_in?
		@program = Program.find(params[:id])

		respond_to do |format|
		  format.html # show.html.erb
		  format.json { render json: @program }
		end
	else
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # GET /programs/new
  # GET /programs/new.json
  def new
	if user_signed_in?
		@program = Program.new

		respond_to do |format|
		  format.html # new.html.erb
		  format.json { render json: @program }
		end
	else
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # GET /programs/1/edit
  def edit
	if user_signed_in?
		@program = Program.find(params[:id])
	else
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # POST /programs
  # POST /programs.json
  def create
	if user_signed_in?
		@program = Program.new(params[:program])

		respond_to do |format|
		  if @program.save
			format.html { redirect_to @program, notice: 'Program was successfully created.' }
			format.json { render json: @program, status: :created, location: @program }
		  else
			format.html { render action: "new" }
			format.json { render json: @program.errors, status: :unprocessable_entity }
		  end
		end
	else
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # PUT /programs/1
  # PUT /programs/1.json
  def update
	if user_signed_in?
		if current_role_id == 1 || current_role_id == 2
			@program = Program.find(params[:id])

			respond_to do |format|
			  if @program.update_attributes(params[:program])
				format.html { redirect_to @program, notice: 'Program was successfully updated.' }
				format.json { head :no_content }
			  else
				format.html { render action: "edit" }
				format.json { render json: @program.errors, status: :unprocessable_entity }
			  end
		else
			redirect_to :controller=>'dashboard', :action => 'index'
		end
	else
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # DELETE /programs/1
  # DELETE /programs/1.json
  def destroy
	if user_signed_in?
		if current_role_id == 1 || current_role_id == 2
			@program = Program.find(params[:id])
			@program.destroy

			respond_to do |format|
			  format.html { redirect_to programs_url }
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
    filename = I18n.l(Time.now, :format => :short) + "- eventtypes.csv"
    content = Program.to_csv(params)
    send_data content, :filename => filename
  end
  
  def export_xls(params)
		filename = I18n.l(Time.now, :format => :short) + "- eventtypes.xls"
		content = Program.to_csv(params)
		send_data content, :filename => filename
  end
  
  
end

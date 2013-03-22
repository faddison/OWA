class ProgramsController < ApplicationController
  # GET /programs
  # GET /programs.json
  def index
	if staff_signed_in?
		@programs = Program.search(params[:search])

		respond_to do |format|
		 format.html # index.html.erb
		  format.csv  {	export_csv(@programs)}
		  format.json { render json: @programs }
		  format.xls  { export_xls(@programs) }	
		end
	else
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # GET /programs/1
  # GET /programs/1.json
  def show
    @program = Program.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @program }
    end
  end

  # GET /programs/new
  # GET /programs/new.json
  def new
    @program = Program.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @program }
    end
  end

  # GET /programs/1/edit
  def edit
    @program = Program.find(params[:id])
  end

  # POST /programs
  # POST /programs.json
  def create
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
  end

  # PUT /programs/1
  # PUT /programs/1.json
  def update
    @program = Program.find(params[:id])

    respond_to do |format|
      if @program.update_attributes(params[:program])
        format.html { redirect_to @program, notice: 'Program was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /programs/1
  # DELETE /programs/1.json
  def destroy
    @program = Program.find(params[:id])
    @program.destroy

    respond_to do |format|
      format.html { redirect_to programs_url }
      format.json { head :no_content }
    end
  end
   def export_csv(eventtypes)
    filename = I18n.l(Time.now, :format => :short) + "- eventtypes.csv"
    content = Program.to_csv
    send_data content, :filename => filename
  end
  
  def export_xls(eventtypes)
		filename = I18n.l(Time.now, :format => :short) + "- eventtypes.xls"
		content = Program.to_csv(col_sep: "\t")
		send_data content, :filename => filename
  end
  
  
end

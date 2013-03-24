class BrochuresController < ApplicationController
  # GET /brochures
  # GET /brochures.json
  def index
	if staff_signed_in?
			@brochures = Brochure.search(params[:search])
			respond_to do |format|
				format.html # index.html.erb
				format.csv  {	export_csv(params)}
				format.json { render json: @brochures }
				format.xls  { export_xls(params) }
			end
	else
		redirect_to :controller=>'home', :action => 'index'
	end
  end

  # GET /brochures/1
  # GET /brochures/1.json
  def show
    @brochure = Brochure.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @brochure }
    end
  end

  # GET /brochures/new
  # GET /brochures/new.json
  def new
    @brochure = Brochure.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @brochure }
    end
  end

  # GET /brochures/1/edit
  def edit
    @brochure = Brochure.find(params[:id])
  end

  # POST /brochures
  # POST /brochures.json
  def create
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
  end

  # PUT /brochures/1
  # PUT /brochures/1.json
  def update
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
  end

  # DELETE /brochures/1
  # DELETE /brochures/1.json
  def destroy
    @brochure = Brochure.find(params[:id])
    @brochure.destroy

    respond_to do |format|
      format.html { redirect_to brochures_url }
      format.json { head :no_content }
    end
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

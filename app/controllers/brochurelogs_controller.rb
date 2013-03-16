class BrochurelogsController < ApplicationController
  # GET /brochurelogs
  # GET /brochurelogs.json 
  def index
    @brochurelogs = Brochurelog.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @brochurelogs }
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
	@rid = @brochurelog.brochure_id
	@fid = @brochurelog.facility_id
	@d = @brochurelog.date
	
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

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
      if @referrallog.save
        format.html { redirect_to @referrallog, notice: 'Referrallog was successfully created.' }
        format.json { render json: @referrallog, status: :created, location: @referrallog }
      else
        format.html { render action: "new" }
        format.json { render json: @referrallog.errors, status: :unprocessable_entity }
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
end

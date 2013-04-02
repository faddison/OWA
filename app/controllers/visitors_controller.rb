class VisitorsController < ApplicationController
  # GET /visitors
  # GET /visitors.json
  load_and_authorize_resource
  #http_basic_authenticate_with :name => "ccunandy@yahoo.com", :password => "ccandy881103", :only => :destroy
  
  
  def index
		
			@visitors = Visitor.metasearch(params[:search])
			Appbeta13::Application.config.current_user_id = -1
			respond_to do |format|
			  format.html # index.html.erb
			  format.csv  {	export_csv(params)}
			  format.json { render json: @visitors }
			  format.xls  { export_xls(params) }
			end
		end

  # GET /visitors/1
  # GET /visitors/1.json
  def show
		
			@visitor = Visitor.find(params[:id])
			if Appbeta13::Application.config.current_user_id != @visitor.id 
					Appbeta13::Application.config.current_user_id = -1
					respond_to do |format|
						format.html # show.html.erb
						format.json { render json: @visitor }
					end
			else
					flash[:notice] = "You don't have access to this page!"
					@i = Appbeta13::Application.config.current_user_id
					#redirect_to action => "show", :id => 17
					@visitor.id = @i
					#@visitor = Visitor.find(session[:@i
					redirect_to visitors_path(session[:visitor_id])
					return
			end	
		end

  # GET /visitors/new
  # GET /visitors/new.json
  def new
	@visitor = Visitor.new

	respond_to do |format|
		 format.html # new.html.erb
		 format.json { render json: @visitor }
	end
  end

  # GET /visitors/1/edit
  def edit
	 
		@visitor = Visitor.find(params[:id])
	end

  # POST /visitors
  # POST /visitors.json
  def create
		
			@visitor = Visitor.new(params[:visitor])
			@visitor.name = Visitor.full_name(@visitor.fname,@visitor.lname)
			@visitor.status = "not approved"
			respond_to do |format|
					if @visitor.save
						format.html { redirect_to @visitor, notice: 'Visitor was successfully created.' }
						format.json { render json: @visitor, status: :created, location: @visitor }
						format.json { render json: @visitor}
						Appbeta13::Application.config.current_user_id = @visitor.id
						@i = Appbeta13::Application.config.current_user_id
						session[:@i] = @visitor.id
					else
						format.html { render action: "new" }
						format.json { render json: @visitor.errors, status: :unprocessable_entity }
					end
				end
		end

  # PUT /visitors/1
  # PUT /visitors/1.json
  def update
	 
		
			@visitor = Visitor.find(params[:id])

			respond_to do |format|
			  if @visitor.update_attributes(params[:visitor])
				format.html { redirect_to @visitor, notice: 'Visitor was successfully updated.' }
				format.json { head :no_content }
			  else
				format.html { render action: "edit" }
				format.json { render json: @visitor.errors, status: :unprocessable_entity }
			  end
			end
	
  end

  # DELETE /visitors/1
  # DELETE /visitors/1.json
  def destroy
	 
		
			@visitor = Visitor.find(params[:id])
			@visitor.destroy

			respond_to do |format|
			  format.html { redirect_to visitors_url }
			  format.json { head :no_content }
			end
		
	
  end
  
  def approve
		_approve(Visitor.find(params[:id]))
	end
 
  def export_csv(params)
    filename = I18n.l(Time.now, :format => :short) + "- visitors.csv"
    content = Visitor.to_csv(params)
    send_data content, :filename => filename
  end
  
  def export_xls(params)
		filename = I18n.l(Time.now, :format => :short) + "- visitors.xls"
		content = Visitor.to_csv(params)
		send_data content, :filename => filename
  end
  
end

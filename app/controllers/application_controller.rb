class ApplicationController < ActionController::Base
  #protect_from_forgery
  @database_id = 1
  helper :all
	include ApplicationHelper
	
	def auth_redirect(url)
		auth_msg
		redirect_to url
	end
	
	def redirect_auth(controller)
		auth_msg
		redirect_to :controller => controller, :action => 'index'
	end
	
	def redirect_index(controller)
		redirect_to :controller => controller, :action => 'index'
	end
	
	def redirect_home
		auth_msg
		redirect_index('home')
	end
	
	def auth_back
		auth_msg
		redirect_to :back
	end
	
	def auth_msg
		flash[:notice] = "You don't have access to do that"
	end
	
	def _approve(object)
		@object = object
		@object.status = (@object.status.downcase == 'approved')? 'not approved':'approved'
		@object.save
		respond_to do |format|
			format.html { redirect_to :back }
			format.json { head :no_content }
		end
	end
	
	def _export_csv(params)
    filename = I18n.l(Time.now, :format => :short) + "- referrals.csv"
    content = Referral.to_csv(params)
    send_data content, :filename => filename
  end
end

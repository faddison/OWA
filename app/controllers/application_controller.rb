class ApplicationController < ActionController::Base
  #protect_from_forgery
  @database_id = 1
  helper :all
	
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
		if !(user_signed_in? && current_user.role_id == 1) 
			auth_back
		else
			@object = object
			@object.status = (@object.status.downcase == 'approved')? 'not approved':'approved'
			@object.save
			respond_to do |format|
				format.html { redirect_to :back }
				format.json { head :no_content }
			end
		end
	end
end

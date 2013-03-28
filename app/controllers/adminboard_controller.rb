class AdminboardController < ApplicationController
	
	def index
		if !user_signed_in? || current_user.role_id != 1
			redirect_to :controller=>'home', :action => 'index'
			
			
		end
		Appbeta13::Application.config.current_user_id = -1
		
	end
end

class HomeController < ApplicationController
  def index
	Appbeta13::Application.config.current_user_id = -1
	if user_signed_in?
		if current_user.role_id == 1
			redirect_to :controller=>'adminboard', :action => 'index'
		else
			redirect_to :controller=>'dashboard', :action => 'index'
		end
	end
  end
end
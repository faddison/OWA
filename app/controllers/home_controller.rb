class HomeController < ApplicationController
  def index
	Appbeta13::Application.config.current_user_id = -1
	if staff_signed_in?
		redirect_to :controller=>'dashboard', :action => 'index'
	end
  end
end

class HomeController < ApplicationController
  def index
	if staff_signed_in?
		redirect_to :controller=>'dashboard', :action => 'index'
	end
  end
end

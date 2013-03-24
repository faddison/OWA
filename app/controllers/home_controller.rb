class HomeController < ApplicationController
  def index
	Appbeta13::Application.config.current_user_id = -1
  end
end

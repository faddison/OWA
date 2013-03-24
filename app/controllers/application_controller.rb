class ApplicationController < ActionController::Base
  protect_from_forgery
  def login_required
    redirect_to('/') if current_user.blank?
  end
end

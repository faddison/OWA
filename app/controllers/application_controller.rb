class ApplicationController < ActionController::Base
  protect_from_forgery
  def login_required
    redirect_to('/') if current_staff.blank?
  end
end

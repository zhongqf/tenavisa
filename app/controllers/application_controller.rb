# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include ApplicationHelper

  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  helper :all # include all helpers, all the time
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  #before_filter :login_required
  
  before_filter :password_expired_check
  
  layout 'layout'
  
  def password_expired_check
    return unless logged_in?
    
    if (current_account.password_expires_at.nil? || current_account.password_expires_at <= Time.now)
      store_location
      redirect_to password_reset_path
    end
  end
  
  def random_password
    "RANDOM_PASSWORD"
  end
  
end

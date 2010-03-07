# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  before_filter :login_required
  
  layout 'layout'
  
  def educatee_required
    ( !! current_educatee ) || access_denied
  end
  
  def current_educatee
    return current_account.loginable if current_account && current_account.loginable.is_a?(Educatee)
    nil
  end
  
  def educator_required
    ( !!current_educator ) || access_denied
  end
  
  def current_educator
    return current_account.loginable if current_account && current_account.loginable.is_a?(Educator)
    nil
  end
  
  def operator_required
    ( !!current_operator ) || access_denied
  end
  
  def current_operator
    return current_account.loginable if current_account && current_account.loginable.is_a?(Operator)
    nil
  end
end

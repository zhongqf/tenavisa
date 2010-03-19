# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

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
    ( !!current_educator && current_educator.operator? ) || access_denied
  end
end

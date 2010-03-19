class AccountsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  skip_before_filter :login_required
  skip_before_filter :password_expired_check, :only => [:password_reset, :reset_password]
  

  # render new.rhtml
  def new
    @account = Account.new
  end
 
  def create
    logout_keeping_session!
    @account = Account.new(params[:account])
    @educatee = Educatee.new
    success = @account && ( @account.loginable = @educatee ) && @account.save 
    if success && @account.errors.empty?
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
  
  def password_reset
    @account = current_account
  end
  
  def reset_password
    @account = current_account
    @account.send(:attributes=, params[:account].merge(:password_expires_at => "9999/12/31 23:59:59"), false )
    if @account.save
      flash[:notice] = "Your password reseted. Relogin please."
      logout_keeping_session!
      redirect_back_or_default('/')
    else
      flash[:notice] = "Cannot reset your password. please try again."
      redirect_to :back
    end
    
  end

  def activate
    logout_keeping_session!
    account = Account.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && account && !account.active?
      account.activate!
      self.current_account = account
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to '/'
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "We couldn't find a account with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/')
    end
  end
end

class Educator::EducatorsController < ApplicationController
  before_filter :operator_required
  
  def index
    @educators = Educator.all(:include => :account)
  end

  def new
  end

  def create
    account_info = params[:account]
    password = random_password
    account_info.merge!(:password => password, :password_confirmation => password, :password_expires_at => 1.days.ago)
    @account = Account.new(account_info)
    @educator = Educator.new(:is_operator => params[:operator])
    success = @account && ( @account.loginable = @educator ) && @account.save
    if success && @account.errors.empty?
      redirect_to educator_educators_path
      flash[:notice] = "We sent a mail that contains activating and password resetting instruction."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      redirect_to :back
    end  
  end

  def edit
  end

  def update
  end

  def destroy
  end

end

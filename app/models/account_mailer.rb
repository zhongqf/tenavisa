class AccountMailer < ActionMailer::Base
  def signup_notification(account)
    setup_email(account)
    @subject    += 'Please activate your new account'
  
    @body[:url]  = "http://YOURSITE/activate/#{account.activation_code}"
  
  end
  
  def activation(account)
    setup_email(account)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://YOURSITE/"
  end
  
  protected
    def setup_email(account)
      @recipients  = "#{account.email}"
      @from        = "ADMINEMAIL"
      @subject     = "[YOURSITE] "
      @sent_on     = Time.now
      @body[:account] = account
    end
end

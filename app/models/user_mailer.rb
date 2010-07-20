class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'  
    @body[:url]  = "http://#{ActionMailer::Base.default_url_options[:host]}/activate/#{user.activation_code}"  
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://#{ActionMailer::Base.default_url_options[:host]}"
  end
  
  def forgot_password(user)
    setup_email(user)
    @subject    += 'You have requested to change your password'
    @body[:url]  = "http://#{ActionMailer::Base.default_url_options[:host]}/reset_password/#{user.password_reset_code}"
  end
 
  def reset_password(user)
    setup_email(user)
    @subject    += 'Your password has been reset.'
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "no-reply@jobmia.com"
      @subject     = "Jobmia - "
      @sent_on     = Time.now
      @body[:user] = user
    end
end
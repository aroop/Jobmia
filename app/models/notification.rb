class Notification < ActionMailer::Base
  def contactus(subject, recipient, from, message)
    @subject    = subject
    @recipients = recipient
    @from = from
    @sent_on = Time.now
    @body       = message
    @headers["reply-to"] = from
  end
  
  def email_resume(subject, recipient, from, message, content_type, file_name, content)
    @subject    = subject
    @recipients = recipient
    @from = from
    @sent_on = Time.now
    @body       = message
    @headers["reply-to"] = from
    attachment :content_type => content_type, :filename => file_name do |a|
    	a.body = content
    end
  end
  
end
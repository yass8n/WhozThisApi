class TextMailer < ActionMailer::Base
  default from: "(800) 888-2793"

    def contact(recipient, subject, message, sent_at = Time.now)
      @subject = subject
      @recipients = recipient
      @from = 'no-reply@yourdomain.com'
      @sent_on = sent_at
	  @body["title"] = 'This is title'
  	  @body["email"] = 'sender@yourdomain.com'
   	  @body["message"] = message
      @headers = {}
   end
   def send_text_message(phone)
    # mail( :to => phone+"@txt.att.net")
    # mail( :to => phone+"@mms.att.net")
    # mail( :to => phone+"@tmomail.net")
    # mail( :to => phone+"@vtext.com")
    # mail( :to => phone+"@vzwpix.com")
    mail( :to => phone+"@messaging.sprintpcs.com")
    # mail( :to => phone+"@pm.sprint.com")
    # mail( :to => phone+"@mymetropcs.com")
    # mail( :to => phone+"@message.alltel.com")
    # mail( :to => phone+"@vmobl.com")
  end
end

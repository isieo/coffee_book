ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.gmail.com",  
  :port                 => 587,  
  :domain               => "brainbytes.org",  
  :user_name            => "gan@brainbytes.org",  
  :password             => "1234testing",  
  :authentication       => "plain",  
  :enable_starttls_auto => true  
}
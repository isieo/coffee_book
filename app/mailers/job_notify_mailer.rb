class JobNotifyMailer < ActionMailer::Base
  default from: "gan@brainbytes.org"
  
  def job_applied(recipient, applicant, job)
    @recipient = recipient
    @applicant = applicant
    @job = job
    mail(:to => @recipient.email, :subject => "Job Applied")
  end
end

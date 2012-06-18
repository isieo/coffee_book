class NotifyJob < Struct.new(:recipient_id, :applicant_id, :job_id)
  def perform
    recipient = User.find(recipient_id)
    applicant = User.find(applicant_id)
    job = Job.find(job_id)
    JobNotifyMailer.job_applied(recipient, applicant, job).deliver
  end
end
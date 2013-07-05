class UserMailer < ActionMailer::Base
  default from: "notification@8vice.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.job_application_notification.subject
  #
  def job_application_notification(application)
    @application = application

    mail to: application.company.admins.first.email, subject: "Somone applied to your job"
  end
  
  def job_approved_notification(application)
    @application = application

    mail to: application.user.email, subject: "Your job application has been approved!"
  end
  
  def job_rejected_notification(application)
    @application = application

    mail to: application.user.email, subject: "Your job application has been rejected!"
  end
end

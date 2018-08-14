class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.error_mail.subject
  #
  def error_mail(msg)
    @msg = msg
    mail to: "to@example.org", subject: "CSV upload error"
  end

  def success_mail
  	mail to: "to@example.org", subject: "CSV imported successfully"
  end
end

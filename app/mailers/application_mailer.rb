class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  def registration_confirmation(user)
    @user = user
    @greeting = "Hi"

    mail(:to => "#{user.firstname} <#{user.email}>", :subject => "Please confirm your registration")
  end 
end

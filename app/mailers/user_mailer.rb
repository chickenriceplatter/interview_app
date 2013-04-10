class UserMailer < ActionMailer::Base
  default from: "hireaflatironer@gmail.com"

  
  def password_reset(user)
    @user = user

    mail to: user.mail, :subject => "Flatiron Hire Password Reset"
  end
end

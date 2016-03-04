class UserMailer < ActionMailer::Base
  default from: "example@example.com"

  def delete_user(user)
    @user = user
    @url = 'http://example.com/'
    mail(to: @user.email, 
      subject: 'Your account has been succesfully deleted'
    )
  end
end

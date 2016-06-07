class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.login.subject
  #
  def login user
    @user = user
    mail to: user.email, subject: "Quinielitas: Ingresar al sistema"
  end
end

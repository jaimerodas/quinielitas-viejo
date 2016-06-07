# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/login
  def login
    user = User.first
    user.email_token = ApplicationRecord.generate_unique_secure_token()
    UserMailer.login(user)
  end

end

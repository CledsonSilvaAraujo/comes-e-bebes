# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/confirm
  def confirm
    UserMailer.confirm
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/forgot
  def forgot
    UserMailer.forgot
  end

end

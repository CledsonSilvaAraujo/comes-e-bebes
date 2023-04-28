class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.confirm.subject
  #
  def confirm
    
    @user = params[:user]
    
    mail(to: @user.email, subject: "Confirmação de conta")
    
  end

  def repeat_token
    @user = params[:user]

    mail(to: @user.email, subject: "Confirmação de conta novamente")
  end
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.forgot.subject
  #
  def forgot
    @user = params[:user]

    mail(to: @user.email, subject: "Esqueci minha senha")
  end
end

class UserMailer < ApplicationMailer
  default from: ENV['SENDGRID_EMAIL_VALID']
  layout 'mailer'

  # def send_email_confirmation
  #   @user = params[:user]
  #   @url = "http://127.0.0.1:3000/email/confirmation/#{@user.token_id}"
  #   mail(to: @user.email, subject: 'My App - Email Confirmation')
  # end

  def recovery_instructions
    @domain = params[:domain]
    @user = params[:user]
    @url = "#{@domain}/reset/password/form/#{@user.recover_password_token}"
    mail(to: @user.email, subject: 'Paquetería Martínez - Recuperación de contraseña')
  end
end

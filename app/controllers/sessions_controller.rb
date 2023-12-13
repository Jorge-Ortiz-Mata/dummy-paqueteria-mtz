class SessionsController < AuthenticatedController
  skip_before_action :authenticate_user
  before_action :deny_access, only: %i[new create recover reset_password]
  before_action :find_user_by_recover_password_token, only: %i[reset_password_form update_password]
  layout 'unauthenticated'

  def new
    @session_form = SessionForm.new
  end

  def create
    @session_form = SessionForm.new session_params

    if @session_form.save
      session[:user_id] = User.find_by(email: session_params[:email]).id
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to login_path
  end

  def recover
    @recover_password = RecoverPassword.new
  end

  def reset_password
    @recover_password = RecoverPassword.new reset_password_params

    if @recover_password.save
      user = User.find_by(email: @recover_password.email)
      UserMailer.with(domain: request.origin, user: user).recovery_instructions.deliver_later

      render :instructions_send, status: :ok
    else
      render :recover, status: :unprocessable_entity
    end
  end

  def instructions_send; end

  def reset_password_form
    @password_reset = PasswordReset.new
  end

  def update_password
    @password_reset = PasswordReset.new password_reset_params

    if @password_reset.save
      @user.update(password_reset_params)
      @user.regenerate_recover_password_token

      redirect_to login_path, notice: 'Tu contraseña ha sido actualizada correctamente'
    else
      render :reset_password_form, status: :unprocessable_entity
    end
  end

  private

  def session_params
    params.require(:session_form).permit(:email, :password)
  end

  def reset_password_params
    params.require(:recover_password).permit(:email)
  end

  def password_reset_params
    params.require(:password_reset).permit(:password, :password_confirmation)
  end

  def find_user_by_recover_password_token
    @user = User.find_by(recover_password_token: params[:recover_password_token])
  end
end

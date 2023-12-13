class UsersController < AuthenticatedController
  skip_before_action :authenticate_user, only: %i[create confirm_account]
  before_action :deny_access, only: %i[create]
  before_action :set_user, only: %i[edit update show destroy confirm_account]
  before_action :authorize_user, only: %i[edit update destroy]
  layout 'unauthenticated', only: %i[create]

  def edit
    @update_account = UpdateAccount.new({
                                          id: current_user.id,
                                          email: current_user.email,
                                          password: current_user.password,
                                          password_confirmation: '',
                                          old_password: '',
                                          token_id: current_user.token_id
                                        })
  end

  def show; end

  def create
    @user = User.new user_params

    if @user.save
      # UserMailer.with(user: @user).send_email_confirmation.deliver_later
      redirect_to login_path, notice: 'El usuario ha sido añadido exitosamente'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @update_account = UpdateAccount.new({
                                          id: current_user.id,
                                          email: account_params[:email],
                                          password: account_params[:password],
                                          password_confirmation: account_params[:password_confirmation],
                                          old_password: account_params[:old_password],
                                          token_id: current_user.token_id
                                        })

    if @update_account.save
      redirect_to user_path(current_user.token_id), notice: 'Tu cuenta ha sido actualizada exitosamente'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    @user.destroy

    redirect_to login_path, notice: 'Tu cuenta ha sido desactivada exitosamente'
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def account_params
    params.require(:update_account).permit(:email, :password, :password_confirmation, :old_password)
  end

  def set_user
    @user = User.find_by(token_id: params[:token_id])
    return @user if @user.present?

    redirect_to root_path, notice: 'No existe ningún usuario con este registro'
  end

  def authorize_user
    return if current_user.eql? @user

    redirect_to root_path, notice: 'No estas autorizado para realizar este procedimiento'
  end
end

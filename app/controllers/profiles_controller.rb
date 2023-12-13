class ProfilesController < AuthenticatedController
  before_action :set_user
  before_action :authorize_user
  before_action :set_profile

  def edit; end

  def update
    if @profile.update profile_params
      redirect_to user_path(current_user.token_id), notice: 'Tu información ha sido actualizada correctamente'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find_by(token_id: params[:user_id])
    return @user if @user.present?

    redirect_to root_path, notice: 'No existe ningún usuario con este registro'
  end

  def authorize_user
    return if current_user.eql? @user

    redirect_to root_path, notice: 'No estas autorizado para realizar este procedimiento'
  end

  def set_profile
    @profile = current_user.profile
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :phone_number)
  end
end

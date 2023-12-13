module Admin
  class UsersController < AuthenticatedController
    before_action :authorize_user
    before_action :set_user, only: %i[edit update destroy]

    def index
      @users = User.joins(:profile).order(:first_name)
    end

    def new
      @user = Admin::CreateUser.new
    end

    def edit
      @admin_user = Admin::UpdateAccount.new({ email: @user.email, role: @user.role, token_id: @user.token_id })
      @admin_user_profile = Admin::UpdateProfile.new({ first_name: @profile.first_name, last_name: @profile.last_name, phone_number: @profile.phone_number, token_id: @user.token_id })
    end

    def create
      @user = Admin::CreateUser.new create_user_params

      respond_to do |format|
        if @user.save
          format.html { redirect_to admin_users_path, notice: 'El usuario ha sido creado exitosamente' }
        else
          format.turbo_stream { render turbo_stream: turbo_stream.replace('new_admin_user_form', partial: 'admin/users/forms/new_user', locals: { user: @user }) }
        end
      end
    end

    def update
      @admin_user = Admin::UpdateAccount.new admin_update_account_params

      respond_to do |format|
        if @admin_user.save
          format.html { redirect_to admin_users_path, notice: 'El usuario ha sido actualizado exitosamente' }
        else
          format.turbo_stream { render turbo_stream: turbo_stream.replace('edit_admin_user_account', partial: 'admin/users/forms/edit_account', locals: { user: @admin_user, state: '' }) }
        end
      end
    end

    def update_profile
      @admin_user_profile = Admin::UpdateProfile.new admin_update_profile_params

      respond_to do |format|
        if @admin_user_profile.save
          format.html { redirect_to admin_users_path, notice: 'El usuario ha sido actualizado exitosamente' }
        else
          format.turbo_stream { render turbo_stream: turbo_stream.replace('edit_admin_user_profile', partial: 'admin/users/forms/edit_profile', locals: { user: @admin_user_profile, state: '' }) }
        end
      end
    end

    def destroy
      session[:user_id] = nil if @user.eql? current_user
      @user.destroy

      respond_to do |format|
        format.html { redirect_to admin_users_path, notice: 'El usuario ha sido eliminado exitosamente' }
      end
    end

    private

    def set_user
      @user = User.find_by(token_id: params[:id])
      @profile = @user.profile
    end

    def authorize_user
      authorize current_user
    end

    def create_user_params
      params.require(:admin_create_user).permit(:email, :password, :first_name, :last_name, :phone_number, :role)
    end

    def admin_update_account_params
      params.require(:admin_update_account).permit(:email, :password, :role, :token_id)
    end

    def admin_update_profile_params
      params.require(:admin_update_profile).permit(:first_name, :last_name, :phone_number, :token_id)
    end
  end
end

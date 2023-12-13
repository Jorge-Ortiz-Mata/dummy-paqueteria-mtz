class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    flash[:notice] = 'No tienes los permisos necesarios para realizar esta acción'
    redirect_to(root_path)
  end
end

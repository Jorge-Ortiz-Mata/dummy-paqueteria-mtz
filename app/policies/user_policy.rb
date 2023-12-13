class UserPolicy < ApplicationPolicy
  # class Scope < Scope
  #   def resolve
  #     scope
  #   end
  # end

  def index?
    @user.admin?
  end

  alias new? index?
  alias create? index?
  alias edit? index?
  alias update? index?
  alias update_profile? index?
  alias destroy? index?
end

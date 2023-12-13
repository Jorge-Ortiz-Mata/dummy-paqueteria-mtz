class DepartureDatePolicy < ApplicationPolicy
  # class Scope < Scope
  #   def resolve
  #     scope
  #   end
  # end

  def index?
    @user.editor? || @user.admin?
  end

  alias new? index?
  alias create? index?
  alias edit? index?
  alias show? index?
  alias update? index?
  alias destroy? index?
end

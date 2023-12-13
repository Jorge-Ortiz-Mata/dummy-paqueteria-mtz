class ArticleSellPolicy < ApplicationPolicy
  # class Scope < Scope
  #   # NOTE: Be explicit about which records you allow access to!
  #   def resolve
  #     scope.all
  #   end
  # end

  def edit?
    @user.editor? || @user.admin?
  end

  alias create? edit?
  alias update? edit?
  alias destroy? edit?
end

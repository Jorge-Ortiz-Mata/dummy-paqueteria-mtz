class ArticlePolicy < ApplicationPolicy
  # class Scope < Scope
  #   # NOTE: Be explicit about which records you allow access to!
  #   def resolve
  #     scope.all
  #   end
  # end

  def index?
    @user.editor? || @user.admin?
  end

  alias show? index?
  alias new? index?
  alias edit? index?
  alias create? index?
  alias update? index?
  alias destroy? index?
end

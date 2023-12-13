class SellPolicy < ApplicationPolicy
  # class Scope < Scope
  #   def resolve
  #     scope
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
  alias export_pdf? index?
  alias edit_remitent_destinatary? index?
  alias update_remitent_destinatary? index?
  alias estafeta_info? index?
  alias send_whatsapp? index?
  alias shipment_number? index?
end

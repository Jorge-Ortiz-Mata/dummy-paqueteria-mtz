module Admin::UsersHelper
  def humanize_role(role)
    return 'Admin' if role.eql? 'admin'
    return 'Editor' if role.eql? 'editor'
    return 'Visita'
  end
end

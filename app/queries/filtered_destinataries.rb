# frozen_string_literal: true

class FilteredDestinataries
  def self.call(...)
    new.call(...)
  end

  def call(filters = {})
    full_name = filters[:full_name]
    remitent = Remitent.find(filters[:remitent_id])

    return if remitent.blank?

    remitent.destinataries.order(:full_name).limit(3).extending(Scopes).by_name(full_name)
  end

  module Scopes
    def by_name(full_name)
      return self unless full_name.present?

      where('full_name LIKE ?', "%#{full_name}%")
    end
  end
end

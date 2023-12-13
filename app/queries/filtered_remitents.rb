# frozen_string_literal: true

class FilteredRemitents
  def self.call(...)
    new.call(...)
  end

  def call(filters = {})
    name = filters[:name]

    Remitent.all.order(:name).limit(3).extending(Scopes).by_name(name)
  end

  module Scopes
    def by_name(name)
      return self unless name.present?

      where('name LIKE ?', "%#{name}%")
    end
  end
end

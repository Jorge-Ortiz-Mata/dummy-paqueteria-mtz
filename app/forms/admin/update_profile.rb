module Admin
  class UpdateProfile
    include ActiveModel::Model

    attr_accessor :first_name, :last_name, :phone_number, :token_id

    validates :first_name, :last_name, :phone_number, presence: true
    validates :phone_number, length: { minimum: 10 }
    validates :phone_number, numericality: { only_integer: true, message: 'debe tener solo números' }

    def save
      return false if invalid?

      profile = User.find_by(token_id: token_id).profile

      profile.update(first_name: first_name, last_name: last_name, phone_number: phone_number)

      true
    end
  end
end

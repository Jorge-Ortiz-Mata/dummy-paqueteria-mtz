module Admin
  class CreateUser
    include ActiveModel::Model

    attr_accessor :email, :password, :first_name, :last_name, :phone_number, :role

    validates :email, :password, :role, presence: true
    validates :password, length: { minimum: 8 }
    validates :phone_number, length: { maximum: 10 }, if: :phone_number_present?
    validates :phone_number, numericality: { only_integer: true, message: 'debe tener solo números' }, if: :phone_number_present?
    validate :no_repeat_email

    def save
      return false if invalid?

      user = User.create(email: email, password: password, password_confirmation: password)

      Profile.find_by(user_id: user.id).update(first_name: first_name, last_name: last_name, phone_number: phone_number)

      true
    end

    private

    def no_repeat_email
      errors.add(:email, :email_exists) if User.find_by(email: email).present?
    end

    def phone_number_present?
      return true if phone_number.present?

      false
    end
  end
end

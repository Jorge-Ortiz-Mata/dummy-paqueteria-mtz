module Admin
  class UpdateAccount
    include ActiveModel::Model

    attr_accessor :email, :password, :role, :token_id

    validates :email, :role, presence: true
    validates :password, length: { minimum: 8 }, if: :password_is_present?
    validate :email_exists?
    validate :role_validation

    def save
      return false if invalid?

      user = User.find_by(token_id: token_id)
      user.update(email: email, password: password, password_confirmation: password, role: User.roles[role])

      true
    end

    private

    def password_is_present?
      return true if password.present?

      false
    end

    def email_exists?
      user = User.find_by(email: email)

      return unless user.present?

      return if user.token_id.eql? token_id

      errors.add(:email, :email_exists)
    end

    def role_validation
      return if User.roles.include?(role)

      errors.add(:role, :invalid_role)
    end
  end
end

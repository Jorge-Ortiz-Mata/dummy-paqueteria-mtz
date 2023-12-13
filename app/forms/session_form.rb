class SessionForm
  include ActiveModel::Model

  attr_accessor :email, :password

  validates :email, :password, presence: true
  validates :password, length: { minimum: 8 }
  validate :user_exists?
  validate :user_authentication

  def save
    return false if invalid?

    true
  end

  private

  def user_exists?
    return unless email.present?

    errors.add(:email, :user_nil) unless User.find_by(email: email).present?
  end

  def user_authentication
    user = User.find_by(email: email)

    return unless user.present?

    errors.add(:password, :incorrect_credentials) unless user&.authenticate(password)
  end
end

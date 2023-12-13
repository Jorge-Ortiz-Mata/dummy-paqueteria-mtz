class RecoverPassword
  include ActiveModel::Model

  attr_accessor :email

  validates :email, presence: true
  validate :email_belongs_to_user

  def save
    return false if invalid?

    true
  end

  private

  def email_belongs_to_user
    return if User.find_by(email: email).present?

    errors.add(:email, :does_not_exist)
  end
end

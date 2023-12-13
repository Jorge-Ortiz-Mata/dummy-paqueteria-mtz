class User < ApplicationRecord
  has_secure_password
  has_secure_token :token_id, length: 50
  has_secure_token :recover_password_token, length: 150

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }, on: :create
  validates :password_confirmation, presence: true, length: { minimum: 8 }, on: :create

  has_one :profile, dependent: :destroy

  after_create :create_profile

  enum role: %i[viewer editor admin]

  def created_at_formatted
    I18n.l(created_at, format: :long)
  end

  private

  def create_profile
    Profile.create(user_id: id)
  end
end

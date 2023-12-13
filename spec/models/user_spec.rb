require 'rails_helper'

RSpec.describe User, type: :model do
  let(:default_user) { build(:user, :with_email, :with_password, :with_password_confirmation) }
  let(:user_without_email) { build(:user, :with_password, :with_password_confirmation) }
  let(:user_without_password) { build(:user, :with_email, :with_password_confirmation) }
  let(:user_without_password_confirmation) { build(:user, :with_email, :with_password) }

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:password_confirmation) }
  end

  describe 'associations' do
    it { should have_secure_password }
    it { should have_secure_token(:token_id).ignoring_check_for_db_index }
    it { should have_secure_token(:recover_password_token).ignoring_check_for_db_index }
    it { should validate_length_of(:token_id) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password) }
    it { should validate_presence_of(:password_confirmation) }
    it { should validate_length_of(:password_confirmation) }
  end

  describe 'instance' do
    it 'should be valid' do
      expect(default_user).to be_valid
    end

    it 'should not be valid without email' do
      expect(user_without_email).to_not be_valid
    end

    it 'should not be valid without password' do
      expect(user_without_password).to_not be_valid
    end

    it 'should not be valid without password confirmation' do
      expect(user_without_password_confirmation).to_not be_valid
    end
  end

  describe 'callbacks' do
    it 'should have a profile after the creation process' do
      expect(default_user.profile).to be_nil
      default_user.save
      expect(User.last.profile).to be_present
    end
  end

  describe 'custom methods' do
    it 'should the creation_at date formatted' do
      default_user.save

      expect(User.last.created_at_formatted).to eql(I18n.l(User.last.created_at, format: :long))
    end
  end
end

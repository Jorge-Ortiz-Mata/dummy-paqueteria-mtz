require 'rails_helper'

RSpec.describe Profile, type: :model do
  let(:default_profile) { build(:profile, :with_attributes, :with_user) }
  let(:invalid_profile) { build(:profile) }

  describe 'instances' do
    it 'should be valid' do
      expect(default_profile).to be_valid
    end

    it 'should not be valid' do
      expect(invalid_profile).to be_invalid
    end
  end

  describe 'associations' do
    it { should have_one_attached(:avatar) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name).on(:update) }
    it { should validate_presence_of(:last_name).on(:update) }
    it { should validate_presence_of(:phone_number).on(:update) }
  end

  describe 'public methods' do
    it 'should return the complete user name' do
      default_profile.save

      expect(Profile.last.full_name).to eql('Jorge Ortiz')
    end
  end
end

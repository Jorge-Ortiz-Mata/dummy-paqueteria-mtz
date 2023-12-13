require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ProfilesHelper. For example:
#
# describe ProfilesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ProfilesHelper, type: :helper do
  let(:profile) { create(:profile, :with_attributes, :with_user) }

  it 'should return a hash with the user information' do
    expect(print_profile(profile.user).length).to eql(3)
    expect(print_profile(profile.user)[:first_name]).to eql('Jorge')
    expect(print_profile(profile.user)[:last_name]).to eql('Ortiz')
    expect(print_profile(profile.user)[:phone_number]).to eql('4441234567')
  end

end

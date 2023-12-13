module ProfilesHelper
  def print_profile(user)
    info = { first_name: '--', last_name: '--', phone_number: '--' }

    profile = Profile.find(user.profile.id)

    info[:first_name] = profile.first_name unless profile.first_name.blank?
    info[:last_name] = profile.last_name unless profile.last_name.blank?
    info[:phone_number] = profile.phone_number unless profile.phone_number.blank?

    info
  end
end

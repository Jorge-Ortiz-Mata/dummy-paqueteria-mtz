# default_users = ['juan@gmail.com', 'ana@gmail.com', 'ortiz.mata.jorge@gmail.com']
default_users = ['ortiz.mata.jorge@gmail.com', 'gael4531@gmail.com']

default_users.each do |email|
  user = User.find_by(email: email)

  if user.present?
    user.update(role: 2)
  else
    User.create(email: email, password: '12345678', password_confirmation: '12345678', role: 2)
  end
end

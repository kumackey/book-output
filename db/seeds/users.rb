puts 'Start inserting seed "users" ...'
10.times do
  user = User.create(
     username: Faker::Name.name,
     email: Faker::Internet.unique.email,
     password: "password",
     password_confirmation: "password",
   )
   puts "\"#{user.username}\" has created!"
end

guest_user = User.create(
  username: 'guest',
  email: 'guest@guest',
  password: "guest",
  password_confirmation: "guest",
)
puts "\"#{guest_user.username}\" has created!"
puts 'Start inserting seed "users" ...'
10.times do
  user = User.create(
     username: Faker::Name.name,
     email: Faker::Internet.unique.email,
     password: "password",
     password_confirmation: "password",
   )
   puts "\"#{user.username}\" has created! user.id: #{user.id}"
end

guest_user = User.create(
  username: 'guest',
  email: 'guest@guest.jp',
  password: "guestguest",
  password_confirmation: "guestguest",
)
puts "\"#{guest_user.username}\" has created! guest_user.id: #{guest_user.id}"
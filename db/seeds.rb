# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create(
  name: 'Luis',
  email: 'luisaparicio2004@gmail.com',
  api_key: 'a1b2c3d4e5f6',
  password: 'hello123',
  password_confirmation: 'hello123'
)

User.create(
  name: 'Luis 2',
  email: 'luisaparicio2004@gmail.com',
  api_key: 'a1b2c3d4e5f6g7h8i9',
  password: 'hello123',
  password_confirmation: 'hello123'
)

puts "Users Created"
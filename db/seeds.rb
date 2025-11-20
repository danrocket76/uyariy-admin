# db/seeds.rb

puts "Seeding database..."

# Create the Super Admin if they don't exist
admin = User.find_or_initialize_by(email: 'admin@example.com')
admin.assign_attributes(
  name: 'Super Admin',
  role: :admin,
  password: 'SASadmin25*',
  password_confirmation: 'SASadmin25*'
)
admin.save!

puts "Admin user created/updated successfully!"
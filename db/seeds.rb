# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
car_list = [
	['0000000', 'toyota', 'camry', 15, 'sedan', 'Raleigh', false],
	['0000010', 'toyota', 'corolla', 15, 'sedan', 'Raleigh', false],
	['0000200', 'toyota', 'prius', 15, 'sedan', 'Raleigh', false],
	['0003000', 'toyota', 'mirai', 15, 'sedan', 'Raleigh', false],
	['0040000', 'toyota', 'yaris', 15, 'sedan', 'Raleigh', false],
	['0500000', 'toyota', 'Rav4', 15, 'sedan', 'Raleigh', false]
]

user_list = [
	["Hank", "yul560@eng.ucsd.edu", "superadmin"],
	["YuChia", 'liu19901124@gmail.com', 'superadmin'],
	["Otto", "yhu22@ncsu.edu", "admin"],
	["Mitsui", 'yliu224@ncsu.edu', 'admin'],
	["HYC", "hyc@ucsd.edu", "user"],
	["Bunny", "bunny@ucsd.edu", "user"]
]

car_list.each do |plate, make, model, rate, style, location, checkout|
	Car.create(
		plate: plate,
		make: make,
		model: model,
		rate: rate,
		style: style,
		location: location,
		checkout: checkout
	)
end

user_list.each do |name, email, role|
	user = User.new
	user.username = name
	user.email = email
	user.password = '123456'
	user.password_confirmation = '123456'
	user.save
	user.add_role role
end

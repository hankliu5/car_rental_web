# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
car_list = [
	['0000000', 'Toyota', 'Camry', 30, 'Sedan', 'Raleigh', false],
	['0032100', 'Toyota', 'Camry', 30, 'Sedan', 'Raleigh', false],
	['0827000', 'Toyota', 'Camry', 30, 'Sedan', 'Raleigh', false],
	['0099870', 'Toyota', 'Corolla', 20, 'Sedan', 'Raleigh', false],
	['0103401', 'Toyota', 'Corolla', 20, 'Sedan', 'Cary', false],
	['0EDAS10', 'Toyota', 'Corolla', 20, 'Sedan', 'Cary', false],
	['0000010', 'Toyota', 'Prius', 25, 'Sedan', 'Cary', false],
	['0000200', 'Toyota', 'Prius', 25, 'Coupe', 'Morrisville', false],
	['0003000', 'Toyota', 'Mirai', 32, 'Sedan', 'Morrisville', false],
	['0040000', 'Toyota', 'Yaris', 17, 'Sedan', 'Morrisville', false],
	['0500000', 'Toyota', 'Rav4', 15, 'Sedan', 'Cary', false],
	['8276344', 'Honda', 'CR-V', 35, 'SUV', 'San Diego', false],
	['777FBI7', 'Honda', 'Accord', 18, 'Coupe', 'San Diego', false],
	['CURRY30', 'Honda', 'Civic', 16, 'Sedan', 'San Diego', false],
	['LEBRON6', 'Honda', 'Fit', 21, 'Coupe', 'Irvine', false],
	['MELO007', 'Honda', 'Fit', 21, 'SUV', 'Irvine', false],
	['JORDANS', 'Honda', 'Civic', 30, 'Sedan', 'Irvine', false],
	['THOMPSO', 'Tesla', 'S', 60, 'Coupe', 'Irvine', false],
	['KLAYS11', 'Tesla', 'S', 55, 'Sedan', 'Los Angeles', false],
	['MCGRADY', 'Tesla', 'X', 70, 'SUV', 'Los Angeles', false],
	['STVNASH', 'BMW', '440i', 10, 'Coupe', 'Los Angeles', false],
	['LAKER24', 'BMW', '328i', 18, 'Sedan', 'New York', false],
	['KOBE824', 'BMW', 'X5', 16, 'SUV', 'New York', false],
	['SHAQ034', 'BMW', 'Z4', 14, 'Coupe', 'Boston', false],
	['DIRK034', 'Maserati', 'GranTurismo', 63, 'Coupe', 'Seattle', false],
	['WADE003', 'Maserati', 'Ghibli', 30, 'Sedan', 'Seattle', false],
	['NASH013', 'Maserati', 'Levante', 47, 'SUV', 'Phoenix', false],
	['TMAC001', 'Hyundai', 'Tucson', 26, 'Sedan', 'South Carolina', false],
	['GGYY123', 'Hyundai', 'Tucson', 26, 'Sedan', 'South Carolina', false],
	['TRUMP87', 'Hyundai', 'Elantra', 26, 'Sedan', 'Las Vegas', false],
	['9487HYC', 'Hyundai', 'Elantra', 26, 'Sedan', 'Las Vegas', false],
	['NCSU517', 'Hyundai', 'Accent', 26, 'SUV', 'Florida', false],
	['THX9527', 'Porsche', '911 Carrera', 88, 'Coupe', 'Taiwan', false],
	['THX9487', 'Porsche', '911 Carrera', 88, 'Coupe', 'Taiwan', false],
	['THX0857', 'Porsche', 'Cayenne', 90, 'SUV', 'Austin', false],
	['THX7777', 'Porsche', 'Cayenne', 90, 'SUV', 'Austin', false],
	['SEAFOOD', 'Ford', 'Fusion', 23, 'Sedan', 'Atlanta', false],
	['SEASALT', 'Ford', 'Focus', 44, 'SUV', 'Atlanta', false],
	['SEESEEU', 'Ford', 'Focus', 13, 'SUV', 'Atlanta', false],
	['HYC1717', 'Chevrolet', 'Impala', 22, 'Sedan', 'Indiana', false],
	['HANK123', 'Chevrolet', 'Sonic', 31, 'SUV', 'Indiana', false],
	['HANK456', 'Chevrolet', 'Cruze', 29, 'Sedan', 'Indiana', false]
]

user_list = [
	["Hank", "yul560@eng.ucsd.edu", "superadmin"],
	["YuChia", 'liu19901124@gmail.com', 'superadmin'],
	["Yu-Ching", 'ychu1991@gmail.com', 'superadmin'],
	["OBOV", 'obov@gmail.com', 'admin'],
	["Otto", "yhu22@ncsu.edu", "admin"],
	["Kevin", "kevin@ncsu.edu", "admin"],
	["Mitsui", 'yliu224@ncsu.edu', 'admin'],
	["HYC", "hyc@ucsd.edu", "user"],
	["xxxxCat", "xxxxCat@ucsd.edu", "user"],
	["Z9", "z9@ucsd.edu", "user"],
	["sumade", "sumade@ucsd.edu", "user"],
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

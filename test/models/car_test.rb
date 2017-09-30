require 'test_helper'

class CarTest < ActiveSupport::TestCase
	test 'valid car' do
		car = Car.new(plate: '6MVJ101', make: :'Toyota', model: 'Camry', rate: 30, style: 'Sedan', location: 'Raleigh', checkout: false)
		assert car.valid?
	end

	test 'valid plate with all lowercase' do
		car = Car.new(plate: 'hankliu', make: :'Toyota', model: 'Camry', rate: 30, style: 'Sedan', location: 'Raleigh', checkout: false)
		assert car.valid?
	end

	test 'valid plate with all uppercase' do
		car = Car.new(plate: 'HANKLIU', make: :'Toyota', model: 'Camry', rate: 30, style: 'Sedan', location: 'Raleigh', checkout: false)
		assert car.valid?
	end

	test 'valid plate with uppercase and lowercase' do
		car = Car.new(plate: 'HankLiu', make: :'Toyota', model: 'Camry', rate: 30, style: 'Sedan', location: 'Raleigh', checkout: false)
		assert car.valid?
	end

	test 'valid plate with all numbers' do
		car = Car.new(plate: '1234567', make: :'Toyota', model: 'Camry', rate: 30, style: 'Sedan', location: 'Raleigh', checkout: false)
		assert car.valid?
	end

	test 'no plate number' do
		car = Car.new(make: :'Toyota', model: 'Camry', rate: 30, style: 'Sedan', location: 'Raleigh', checkout: false)
		assert !car.valid?
	end

	test 'plate number more than 7 digits' do
		car = Car.new(plate: '00000000', make: :'Toyota', model: 'Camry', rate: 30, style: 'Sedan', location: 'Raleigh', checkout: false)
		assert !car.valid?
	end

	test 'plate number less than 7 digits' do
		car = Car.new(plate: '000000', make: :'Toyota', model: 'Camry', rate: 30, style: 'Sedan', location: 'Raleigh', checkout: false)
		assert !car.valid?
	end

	test 'plate number contains special symbols' do
		car = Car.new(plate: '000000*', make: :'Toyota', model: 'Camry', rate: 30, style: 'Sedan', location: 'Raleigh', checkout: false)
		assert !car.valid?
	end

end

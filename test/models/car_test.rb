require 'test_helper'

class CarTest < ActiveSupport::TestCase
	test 'valid car' do
		car = Car.new(plate: '6MVJ101', make: :'Toyota', model: 'Camry', rate: 30, style: 'Sedan', location: 'Raleigh', checkout: false)
		assert car.valid?
	end

	# Tests plate
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

	test 'plate number is repeated' do
		Car.create(plate: '1234567', make: :'Toyota', model: 'Camry', rate: 30, style: 'Sedan', location: 'Raleigh', checkout: false)
		repeated_car = Car.new(plate: '1234567', make: :'Toyota', model: 'Camry', rate: 30, style: 'Sedan', location: 'Raleigh', checkout: false)
		assert !repeated_car.save
	end

	# Tests make, model are not presented
	test 'make is not presented' do
		car = Car.new(plate: '0000000', model: 'Camry', rate: 30, style: 'Sedan', location: 'Raleigh', checkout: false)
		assert !car.valid?
	end

	test 'model is not presented' do
		car = Car.new(plate: '000000*', make: :'Toyota', rate: 30, style: 'Sedan', location: 'Raleigh', checkout: false)
		assert !car.valid?
	end

	# Tests rate
	test 'rate is missing' do
		car = Car.new(plate: '6MVJ101', make: :'Toyota', model: 'Camry', style: 'Sedan', location: 'Raleigh', checkout: false)
		assert !car.valid?
	end

	test 'rate is zero' do
		car = Car.new(plate: '6MVJ101', make: :'Toyota', model: 'Camry', rate: 0, style: 'Sedan', location: 'Raleigh', checkout: false)
		assert !car.valid?
	end

	test 'rate is negative' do
		car = Car.new(plate: '6MVJ101', make: :'Toyota', model: 'Camry', rate: -20, style: 'Sedan', location: 'Raleigh', checkout: false)
		assert !car.valid?
	end

	test 'rate is not integer' do
		car = Car.new(plate: '6MVJ101', make: :'Toyota', model: 'Camry', rate: 15.5, style: 'Sedan', location: 'Raleigh', checkout: false)
		assert !car.valid?
	end

	# Tests style
	test 'Coupe car' do
		car = Car.new(plate: '6MVJ101', make: :'Toyota', model: 'Camry', rate: 30, style: 'Coupe', location: 'Raleigh', checkout: false)
		assert car.valid?
	end

	test 'SUV car' do
		car = Car.new(plate: '6MVJ101', make: :'Toyota', model: 'Camry', rate: 30, style: 'SUV', location: 'Raleigh', checkout: false)
		assert car.valid?
	end

	test 'lowercase coupe' do
		car = Car.new(plate: '6MVJ101', make: :'Toyota', model: 'Camry', rate: 30, style: 'coupe', location: 'Raleigh', checkout: false)
		assert !car.valid?
	end

	test 'lowercase suv' do
		car = Car.new(plate: '6MVJ101', make: :'Toyota', model: 'Camry', rate: 30, style: 'suv', location: 'Raleigh', checkout: false)
		assert !car.valid?
	end

	test 'style is missing' do
		car = Car.new(plate: '6MVJ101', make: :'Toyota', model: 'Camry', rate: 30, location: 'Raleigh', checkout: false)
		assert !car.valid?
	end

	test 'style is something else' do
		car = Car.new(plate: '6MVJ101', make: :'Toyota', model: 'Camry', rate: 30, style: 'Hatchback', location: 'Raleigh', checkout: false)
		assert !car.valid?
	end

	# Tests locations
	test 'Location is missing' do
		car = Car.new(plate: '6MVJ101', make: :'Toyota', model: 'Camry', rate: 30, style: 'Coupe', checkout: false)
		assert !car.valid?
	end

	test 'Location contains numbers' do
		car = Car.new(plate: '6MVJ101', make: :'Toyota', model: 'Camry', rate: 30, style: 'Coupe', location: 'Raleigh 27610', checkout: false)
		assert !car.valid?
	end

	test 'Location contains symbols' do
		car = Car.new(plate: '6MVJ101', make: :'Toyota', model: 'Camry', rate: 30, style: 'Coupe', location: 'Raleigh~~~', checkout: false)
		assert !car.valid?
	end

	# Tests checkout column is not nil
	test 'check out is not nil' do
		car = Car.new(plate: '6MVJ101', make: :'Toyota', model: 'Camry', rate: 30, style: 'SUV', location: 'Raleigh')
		car.save
		assert !car.checkout.nil?
	end

	test 'check out is false' do
		car = Car.new(plate: '6MVJ101', make: :'Toyota', model: 'Camry', rate: 30, style: 'SUV', location: 'Raleigh')
		car.save
		assert !car.checkout
	end

	test 'check out is true' do
		car = Car.new(plate: '6MVJ101', make: :'Toyota', model: 'Camry', rate: 30, style: 'SUV', location: 'Raleigh')
		car.checkout = true
		car.save
		assert car.checkout
	end

	# Tests reservation_time is nil
	test 'reservation_time is nil' do
		car = Car.new(plate: '6MVJ101', make: :'Toyota', model: 'Camry', rate: 30, style: 'SUV', location: 'Raleigh')
		car.save
		assert car.reservation_time.nil?
	end

end

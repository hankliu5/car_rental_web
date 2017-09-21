class CarsController < ApplicationController
	def index
		@cars = Car.all
	end

	def new
		@car = Car.new
	end

	def create
		@car = Car.new(car_params)
		@car.checkout = false
		if @car.save
			redirect_to cars_path
		else
			render :new
		end
	end

	def show
		@car = Car.find(params[:id])
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private
	def car_params
		params.require(:car).permit(:plate, :make, :model, :rate, :style, :location)
	end
end

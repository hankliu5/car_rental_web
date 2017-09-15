class CarsController < ApplicationController
  def index
    @cars = Car.all
  end

  def new
    @car = Car.new
  end

  def show
    @car = Car.find(params[:id])
  end

  def edit
    @car = current_user.cars.find(params[:id])
  end

  def update
    @car = current_user.cars.find(params[:id])

    if @car.update(car_params)
      redirect_to cars_path, notice: "Modified Successfully!"
    else
      render :edit
    end
  end

  def create
    @car = current_user.cars.create(car_params)

    if @car.save
      current_user.join!(@car)
      redirect_to cars_path, notice: "Car Created Successfully!"
    else
      render :new
    end
  end

  def destroy
    @car = current_user.cars.find(params[:id])
    @car.destroy
    redirect_to cars_path, alert: "Car Deleted Successfully!"
  end

end

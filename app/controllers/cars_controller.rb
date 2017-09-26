class CarsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  load_and_authorize_resource

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
    @reservations = Reservation.where car_id: @car.id
  end

  def edit
    @car = Car.find(params[:id])
  end

  def update
    @car = Car.find(params[:id])

    if @car.update(car_params)
      redirect_to cars_path, notice: 'Car information has been updated!'
    else
      render :edit
    end
  end

  def destroy
    @car = Car.find(params[:id])
    @car.destroy
    redirect_to cars_path, notice: 'Car information has been deleted!'
  end

  private

  def car_params
    params.require(:car).permit(:plate, :make, :model, :rate, :style, :location)
  end

  def check_status car
      if (car.reservation_time.nil? || (car.reservation_time).to_i < Time.now.to_i && !car.checkout)
          return "available"
      elsif ((car.reservation_time).to_i > Time.now.to_i && !car.checkout)
          return "reserved"
      else
          return "checked out"
      end
  end
  helper_method :check_status

end

require 'will_paginate/array'
class CarsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  load_and_authorize_resource

  def index
    @cars = Car.search(params[:term], params[:category]).paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    @car.checkout = false
    if @car.save
      flash[:success] = "New car has been create!"
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
      flash[:success] = "Car information has been updated!"
      redirect_to cars_path
    else
      render :edit
    end
  end

  def destroy
    @car = Car.find(params[:id])
    @car.destroy
    flash[:success] = "Car information has been deleted!"
    redirect_to cars_path
  end

  private

  def car_params
    params.require(:car).permit(:plate, :make, :model, :rate, :style, :location)
  end

  def check_status car
      if (car.checkout && (car.return_time).to_i < Time.now.to_i)
          car.update_attribute(:checkout, false)
          #@fee =
          return "Available"
      elsif (car.reservation_time.nil?) || (car.reservation_time.to_i < Time.now.to_i) && !car.checkout
          return "Available"
      elsif ((car.reservation_time).to_i > Time.now.to_i) && !car.checkout
          return "Reserved"
      else
          return "Checked Out"
      end
  end
  helper_method :check_status

end

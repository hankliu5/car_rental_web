require 'will_paginate/array'
class CarsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  load_and_authorize_resource

  def index
    @cars = if Rails.env.to_sym == :production && params[:term].present?
              case params[:category].to_sym
              when :make
                Car.search_by_make(params[:term])
              when :model
                Car.search_by_model(params[:term])
              when :style
                Car.search_by_style(params[:term])
              when :location
                Car.search_by_location(params[:term])
              when :status
                cars = [] # array
                Car.all.each do |car|
                  case term
                  when 'available'
                    if car.reservation_time.nil? || (car.reservation_time.to_i < Time.now.to_i) && !car.checkout
                      cars << car
                    end
                  when 'reserved'
                    if (car.reservation_time.to_i > Time.now.to_i) && !car.checkout
                      cars << car
                    end
                  when 'checked out'
                    cars << car if car.checkout
                  end
                end
                cars
              end
            elsif Rails.env.to_sym == :development || Rails.env.to_sym == :test
              Car.order(:make, :model, :rate).search(params[:term], params[:category])
            else
              Car.all
            end
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      flash[:success] = 'New car has been create!'
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
      flash[:success] = 'Car information has been updated!'
      redirect_to cars_path
    else
      render :edit
    end
  end

  def destroy
    @car = Car.find(params[:id])
    @car.destroy
    flash[:success] = 'Car information has been deleted!'
    redirect_to cars_path
  end

  private

  def car_params
    params.require(:car).permit(:plate, :make, :model, :rate, :style, :location)
  end

  def check_status(car)
    if car.checkout && car.return_time.to_i < Time.now.to_i
      car.update_attribute(:checkout, false)
      @reservation = Reservation.find(car.reservation_id)

      @fee = ((@reservation.return_time.to_i - @reservation.pick_up_time.to_i) * car.rate) / 3600
      # pass fee to user's account
      @user = User.find(@reservation.user_id)
      @user.fee += @fee
      @user.update_attribute(:fee, @user.fee)
      'Available'
    elsif car.reservation_time.nil? || (car.reservation_time.to_i < Time.now.to_i) && !car.checkout
      'Available'
    elsif (car.reservation_time.to_i > Time.now.to_i) && !car.checkout
      'Reserved'
    else
      'Checked Out'
    end
  end
  helper_method :check_status
end

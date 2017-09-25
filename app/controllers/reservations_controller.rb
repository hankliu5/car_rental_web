class ReservationsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @all_reservations = Reservation.all
    @user_reservations = []
    @all_reservations.each do |r|
      @user_reservations << r if r.user_id == current_user.id
    end
  end

  def new
    @reservation = Reservation.new
    @car = Car.find(params[:car_id])
    @user = current_user
  end

  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      redirect_to reservations_path
    else
      render :new
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
    @car = Car.find(@reservation.car_id)
    @user = User.find(@reservation.user_id)
  end

  def edit
    @reservation = Reservation.find(params[:id])
    @car = Car.find(params[:car_id])
    @user = User.find(params[:user_id])
  end

  def update
    @reservation = Reservation.find(params[:id])

    if @reservation.update(car_params)
      redirect_to reservations_path, notice: 'Reservation has been updated!'
    else
      render :edit
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to reservations_path, notice: 'Reservation has been deleted!'
  end

  private

  def reservation_params
    params.require(:reservation).permit(:user_id, :car_id, :pick_up_time, :return_time)
  end
end

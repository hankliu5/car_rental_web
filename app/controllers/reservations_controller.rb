class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all
  end

  def new
    @car = Car.find(params[:car_id])
    @reservation = Reservation.new
  end

  def create
    @car = Car.find(params[:car_id])
    @reservation = Reservation.new(reservation_params)
    @reservation.car = @car
    @reservation.user = current_user

    if @reservation.save
      redirect_to reservations_path(@car)
    else
      render :new
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def edit
    @reservation = Reservation.find(params[:id])
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
    params.require(:reservation).permit(:user_id, :car_id)
  end
end

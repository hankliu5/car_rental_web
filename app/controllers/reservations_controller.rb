class ReservationsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  def index
    @all_reservations = Reservation.all.order(pick_up_time: :desc)
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
    @car = Car.find(@reservation.car_id)
    @user = User.find(@reservation.user_id)
    if !check_reservation_invalid? && @reservation.save
        @car.update_attribute(:reservation_time, (@reservation.pick_up_time + 30*60))
        @car.update_attribute(:return_time, (@reservation.return_time))
        @car.update_attribute(:reservation_id, @reservation.id)
        @user.update_attribute(:reservation_id, @reservation.id)
      redirect_to reservation_path(@reservation)
    else
        flash_notice
        render :new
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
    @car = Car.find(@reservation.car_id)
    @user = User.find(@reservation.user_id)
  end

  def check_out
    @reservation = Reservation.find(params[:id])
    @car = Car.find(@reservation.car_id)

    if @car.update_attribute(:checkout, true) && @car.save
      redirect_to reservations_path, notice: "The car #{@car.plate} has been checked out!"
    else
      redirect_to reservation_path(@reservation_path), alert: 'Something went wrong.'
    end
  end

  def return_car
    @reservation = Reservation.find(params[:id])
    @car = Car.find(@reservation.car_id)
    @user = User.find(@reservation.user_id)
    @fee = ((@reservation.return_time.to_i - @reservation.pick_up_time.to_i)/3600) * @car.rate
    @user.fee += @fee
    if @car.update_attribute(:checkout, false) && @car.update_attribute(:reservation_time, nil) && @user.update_attribute(:fee, @user.fee)
      redirect_to reservations_path, notice: "The car #{@car.plate} has been returned! $#{@fee} has been posted to user's account."
    else
      redirect_to reservation_path(@reservation_path), alert: 'Something went wrong.'
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
    @car = Car.find(@reservation.car_id)
    @user = User.find(@reservation.user_id)
  end

  def update
    @reservation = Reservation.find(params[:id])

    if @reservation.update(reservation_params)
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

  def flash_notice
      flash[:notice] = "The pick up time should be prior to return time" if invalid_select_date?
      flash[:notice] = "You can not select past time! (Please reselect your date)" if reserve_past_time?
      flash[:notice] = "You can not advance a reservation by one week (7 days)" if more_than_one_week?
      flash[:notice] = "You can only reserve a car for 1 hour minimum and 10 hours maximum per day" if invalid_reservation_period?
  end

  def check_reservation_invalid?
      invalid_select_date? || reserve_past_time? || more_than_one_week? || invalid_reservation_period?
  end

  def invalid_select_date?
      @reservation.return_time - @reservation.pick_up_time < 0
  end

  def reserve_past_time?
      @reservation.pick_up_time < Time.now
  end

  def more_than_one_week?
      @reservation.return_time - Time.now > 7*24*60*60
  end

  def invalid_reservation_period?
      @period = @reservation.return_time - @reservation.pick_up_time
      (@period < 60*60 && @period > 0) || @period > 10*60*60
  end

end

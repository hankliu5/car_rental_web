class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource except: :create
  skip_authorize_resource only: %i[edit_password update_password]

  def index
    @all_users = User.all
    @superadmins = []
    @admins = []
    @users = []
    @all_users.each do |user|
      if user.has_role? :superadmin
        @superadmins << user
      elsif user.has_role? :admin
        @admins << user
      else
        @users << user
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(new_user_params)
    if @user.save
      @user.add_role(current_user.roles.all[0].name)
      redirect_to users_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @reservations = Reservation.where user_id: @user.id
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(update_user_params)
      redirect_to users_path, notice: 'User information has been updated!'
    else
      render :edit
    end
  end

  def edit_password
    @user = current_user
  end

  def update_password
    @user = current_user
    if @user.update_with_password(update_password_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(@user)
      redirect_to root_path, notice: 'Your password has been modified!'
    else
      render :edit_password
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to users_path, notice: 'User information has been deleted!'
    end
  end

  private

  def check_permission
    redirect_to root_path if current_user && (!current_user.has_role? %i[superadmin admin])
  end

  def update_user_params
    params.require(:user).permit(:username, :email)
  end

  def update_password_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end

  def new_user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end

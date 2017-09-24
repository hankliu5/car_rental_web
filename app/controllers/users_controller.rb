class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_permission

  def index
    @all_users = User.all
    @admins = []
    @users = []
    @all_users.each do |user|
      if user.has_role? :admin
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
		@user.add_role(current_user.roles.find(1).name)
		if @user.save
				redirect_to users_path
		else
				render :new
		end
	end


  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
		admin_try_to_edit_admins
  end

  def update
    @user = User.find(params[:id])
		admin_try_to_edit_admins

    if @user.update(update_user_params)
      redirect_to users_path, notice: 'User information has been updated!'
    else
      render :edit
    end
  end

	def destroy
			@user = User.find(params[:id])
      admin_try_to_edit_admins
			if @user.destroy
  			redirect_to users_path, notice: 'User information has been deleted!'
      end
	end

  private

	def admin_try_to_edit_admins
		if (@user.has_role? :admin) && (current_user.has_role? :admin)
			redirect_to users_path, alert: 'You cannot edit other admins as an admin.'
		end
	end
  def check_permission
    redirect_to root_path if current_user && (!current_user.has_role? :admin)
  end

	def update_user_params
		params.require(:user).permit(:username, :email)
	end

	def new_user_params
		params.require(:user).permit(:username, :email, :password, :password_confirmation)
	end
end

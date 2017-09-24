class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :check_permission

	def index
		@users = User.all
	end

	def show
	  @user = User.find(params[:id])
	end

	private
	def check_permission
		if current_user && (!current_user.has_role? :admin)
			redirect_to root_path
		end
	end
end

class UsersController < ApplicationController

	def index
		@user = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to root_url
			session[:user_id] = @user.id
			flash[:notice] = "Signed up"
		else
			render :new
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def destroy
		# Prevent errors when deleteing users and session searching for the user's id 
		if @current_user == User.find(params[:id])
			session[:user_id] = nil
		end
		@user = User.find(params[:id])
		@user.destroy
		redirect_to root_url
	end

	private
		def user_params
			params.require(:user).permit(:name, :password, :password_confirmation)
		end
end

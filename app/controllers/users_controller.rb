class UsersController < ApplicationController

  def index
  	@users = User.all
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)	
  	if @user.save
      flash[:notice] = "success"
  		redirect_to root_url
  	else
  		render "new"
  	end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_url
    flash[:notice] = "User cancelled"
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :password, :password_confirmation)
  	end
end

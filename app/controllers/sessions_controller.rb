class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.authenticate(params[:name], params[:password])
		if user
			session[:user_id] = user.id
			flash[:notice] = "Signed in"
			redirect_to root_url
		else
			flash[:notice] = "Invalid name or password"
			render :new
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "Signed out"
		redirect_to root_url
	end
end

class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      flash.now[:info] = "Welcome, #{current_user}!"
      redirect_to root_url
    else
      flash.now[:error] = "Invalid user/password combination."
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end

class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[new create]
  rate_limit to: 10, within: 3.minutes, only: :create, with: :rate_limit_exceeded

  def index
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
  end

  def new
    @session = Session.new
  end

  def create
    @user = User.find_by(email_address: params.dig(:session, :email_address))
    if @user&.authenticate(params.dig(:session, :password))
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: 'Logged in successfully'
    else
      flash.now[:alert] = 'Invalid email or password'
      redirect_to root_path
    end
  end

  def destroy
    # Clear session data
    session[:user_id] = nil
    reset_session # Remove all session data

    redirect_to new_session_path, notice: 'Logged out successfully'
  end
end

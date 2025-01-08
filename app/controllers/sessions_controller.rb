class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
    @session = Session.new
  end

  def create
    user = User.find_by(email_address: params[:session]&.[](:email_address))

    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user_path(user), notice: 'Logged in successfully'
    else
      flash.now[:alert] = 'Invalid email or password'
      render :new
    end
  end
  
  def destroy
    terminate_session
    redirect_to new_session_path
  end
end

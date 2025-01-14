class UsersController < ApplicationController

    before_action :set_user, only: %i[ show edit update destroy ]
    before_action :require_login, only: [:edit, :update]
    allow_unauthenticated_access only: %i[ index show ]

  
    def index
  
    end
  
    def show
      @user = current_user
      @lists = @user.lists.includes(:tasks)
      @task = Task.new
    end
    
    def new
      @user = User.new
    end
  
    def create
      @user = User.create(user_params)
      if @user.save
        flash[:success] = "Welcome, #{@user.name}!"
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        Rails.logger.debug("Errors: #{@user.errors.full_messages}")
        flash.now[:alert] = 'Invalid email or password'
        render :new
      end
    end
  
    def edit
    end
  
    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to user_path(@user)
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      @user.destroy
      redirect_to user_path
    end
  
    private
    
    def set_user
      @user = User.find(params[:id])
    end
  
    def user_params
      params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
    end
  
  end
  
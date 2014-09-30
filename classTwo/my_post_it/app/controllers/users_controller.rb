class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You are now registered. Welcome, #{@user.username}."
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Your profile has been updated.'
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:username, :email, :time_zone, :password, :password_confirmation)
  end

  def set_user
    @user = User.find_by slug: params[:id]
  end

  def require_same_user
    deny_access unless logged_in? && current_user == @user
  end
end
class UsersController < ApplicationController
  before_action :set_user, except: [:index, :new, :create]

  def index
    @users = User.all
  end

  def new
  end

  def create
    @user = User.new(user_params)
    @user.save
  end
  
  def show
  end
  
  def edit
    @user = User.find(params[:id])
    @user.save
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to root_path, notice: "success"
    else
      flash[:alert] = "save error"
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :image)
  end

  def set_user
    @user = User.find(params[:id])
  end

end

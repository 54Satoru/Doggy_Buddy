class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
    @user.save
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: "プロフィールの編集に成功しました！！"
    else
      flash[:alert] = "プロフィールの編集に失敗しました！！"
      render :edit
    end
  end

  def following
    @title = "フォロー"
    @user = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(10)
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(10)
    render 'show_follow'
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :image, :remove_image, :profile)
    end

    def set_user
      @user = User.find(params[:id])
    end

end

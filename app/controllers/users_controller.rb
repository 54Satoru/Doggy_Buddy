class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  
  def show
    @user = User.find(params[:id])
    
    #レビュー
    @reviews = Review.where(reviewee_id: @user.id)
    if @user.reviews.blank?
      @average_review = 0
    else
      @average_review = @reviews.average(:rate).to_f.round(1)
    end

    #メッセージ
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      
      unless @isRoom 
        @room = Room.new
        @entry = Entry.new
      end
    end

    #お気に入り
    favorite_cs = @user.favorite_cs.pluck(:post_c_id)
    @favorite_cs = PostC.where(id: favorite_cs)
    favorite_sitters = @user.favorite_sitters.pluck(:post_sitter_id)
    @favorite_sitters = PostSitter.where(id: favorite_sitters)
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

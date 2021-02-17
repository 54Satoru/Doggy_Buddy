class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_review

  def index
    @reviews = Review.where(reviewee_id: @user.id).order("reviews.created_at DESC")
    @review_sitters = Review.where(reviewee_id: @user.id).where(position: "sitter").order("reviews.created_at DESC")
    @review_cs = Review.where(reviewee_id: @user.id).where(position: "c").order("reviews.created_at DESC")
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      @review.create_notification_review!(current_user, @user)
      flash[:notice] = 'レビューを投稿しました'
      redirect_to user_reviews_path
    else
      flash.now[:alert] = '入力に不備があります'
      render :new
    end
  end
  
  def destroy
    
  end

  private

  def set_review
    @user = User.find(params[:user_id])
  end

  def review_params
    params.require(:review).permit(:rate, :content, :position, :user_id, :reviewee_id)
  end

end

class PostCController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = PostC.all
  end

  def show
    @post = PostC.find(params[:id])
    @user = User.find(params[:id])
  end

  def new
    @post = PostC.new
  end

  def create
    @post = PostC.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_c_path(@post)
    else
      render :new
    end
  end

  def edit
    @post = PostC.find(params[:id])
    @post.user_id = current_user.id
    @post.save
  end

  def update
    @post = PostC.find(params[:id])
    if @post.update(post_params)
      redirect_to post_c_path(@post), notice: "投稿内容の編集に成功しました！！"
    else
      flash[:alert] = "投稿内容の編集に失敗しました！！"
      render :edit
    end
  end

  def destroy
    @post = PostC.find(params[:id])
    @post.destroy
    flash[:notice] = '投稿を削除しました'
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post_c).permit(:title, :region, :datetime, :price, :payment, :content, :image, :remove_image)
  end

end

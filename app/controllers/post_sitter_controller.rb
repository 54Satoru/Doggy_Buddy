class PostSitterController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = PostSitter.all
  end

  def show
    @post = PostSitter.find(params[:id])
    @user = User.find(params[:id])
  end

  def new
    @post = PostSitter.new
  end

  def create
    @post = PostSitter.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_sitter_path(@post), notice: "投稿に成功しました！！"
    else
      flash[:alert] = "投稿に失敗しました！！"
      render :new
    end
  end

  def edit
    @post = PostSitter.find(params[:id])
    @post.user_id = current_user.id
    @post.save
  end

  def update
    @post = PostSitter.find(params[:id])
    if @post.update(post_params)
      redirect_to post_sitter_path(@post), notice: "投稿内容の編集に成功しました！！"
    else
      flash[:alert] = "投稿内容の編集に失敗しました！！"
      render :edit
    end
  end

  def destroy
    @post = PostSitter.find(params[:id])
    @post.destroy
    flash[:notice] = '投稿を削除しました'
    redirect_to root_path
  end

  private
  
  def post_params
    params.require(:post_sitter).permit(:title, :region, :datetime, :price, :payment, :content, :image, :remove_image)
  end

  def set_post
    @post = PostSitter.find(params[:id])
  end

end

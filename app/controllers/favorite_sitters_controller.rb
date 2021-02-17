class FavoriteSittersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    if @post.user_id != current_user.id
      @favorite_sitter = FavoriteSitter.create(user_id: current_user.id, post_sitter_id: @post.id)
      @post.create_notification_favorite_sitter!(current_user)
    end
  end

  def destroy
    @favorite_sitter = FavoriteSitter.find_by(user_id: current_user.id, post_sitter_id: @post.id)
    @favorite_sitter.destroy
  end

  private
  def set_post
    @post = PostSitter.find(params[:post_sitter_id])
  end
end

class FavoriteCsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:create, :destroy]

  def create
    if @post.user_id != current_user.id
      @favorite_c = FavoriteC.create(user_id: current_user.id, post_c_id: @post.id)
    end
  end

  def destroy
    @favorite_c = FavoriteC.find_by(user_id: current_user.id, post_c_id: @post.id)
    @favorite_c.destroy
  end

  private
  def set_post
    @post = PostC.find(params[:post_c_id])
  end
end

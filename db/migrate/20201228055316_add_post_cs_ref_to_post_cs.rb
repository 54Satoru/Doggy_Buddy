class AddPostCsRefToPostCs < ActiveRecord::Migration[6.0]
  def change
    add_reference :post_cs, :user, null: false, foreign_key: true
  end
end

class CreateFavoriteSitters < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_sitters do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post_sitter, null: false, foreign_key: true

      t.timestamps
      t.index [:user_id, :post_sitter_id], unique: true
    end
  end
end

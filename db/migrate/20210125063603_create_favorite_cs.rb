class CreateFavoriteCs < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_cs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post_c, null: false, foreign_key: true

      t.timestamps
      t.index [:user_id, :post_c_id], unique: true
    end
  end
end

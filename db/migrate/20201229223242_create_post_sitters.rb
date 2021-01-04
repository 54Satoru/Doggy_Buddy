class CreatePostSitters < ActiveRecord::Migration[6.0]
  def change
    create_table :post_sitters do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :region
      t.string :datetime
      t.string :price
      t.string :payment
      t.string :content

      t.timestamps
    end
  end
end

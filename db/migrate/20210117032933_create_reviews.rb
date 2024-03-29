class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.float :rate
      t.text :content
      t.string :position

      t.timestamps
    end
  end
end

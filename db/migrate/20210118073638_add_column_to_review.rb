class AddColumnToReview < ActiveRecord::Migration[6.0]
  def change
    add_reference :reviews, :reviewee, null: false, foreign_key: {to_table: :users}
  end
end

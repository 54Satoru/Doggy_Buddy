class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :room_id
      t.integer :message_id
      t.integer :post_c_id
      t.integer :post_sitter_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false
      
      t.timestamps
    end
  end
end

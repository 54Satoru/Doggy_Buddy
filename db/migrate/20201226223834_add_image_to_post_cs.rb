class AddImageToPostCs < ActiveRecord::Migration[6.0]
  def change
    add_column :post_cs, :image, :string
  end
end

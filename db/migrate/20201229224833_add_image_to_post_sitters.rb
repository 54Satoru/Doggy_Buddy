class AddImageToPostSitters < ActiveRecord::Migration[6.0]
  def change
    add_column :post_sitters, :image, :string
  end
end

class FavoriteSitter < ApplicationRecord
  belongs_to :user
  belongs_to :post_sitter
end

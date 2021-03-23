require 'rails_helper'

RSpec.describe FavoriteC, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe '#create' do
    let(:user) { create(:user) }
    let(:post) { create(:post_c) }
    let(:favorite) { create(:favorite_c, user: user, post_c: post) }

    it "投稿とユーザーが存在すれば保存される" do
      expect(favorite).to be_valid
    end

    it "一つの投稿に同じユーザーが2回以上保存できない" do
      favorite = build(:favorite_c, user: user, post_c: post)
      favorite.valid?
      expect(favorite.errors[:post_c_id])
    end

    it "投稿が空の場合は保存されない" do
      favorite = build(:favorite_c, post_c: nil)
      favorite.valid?
      expect(favorite.errors[:post_c]).to include("を入力してください")
    end

    it "ユーザーが空の場合は保存されない" do
      favorite = build(:favorite_c, user: nil)
      favorite.valid?
      expect(favorite.errors[:user]).to include("を入力してください")
    end
  end
end

RSpec.describe FavoriteSitter, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe '#create' do
    let(:user) { create(:user) }
    let(:post) { create(:post_sitter) }
    let(:favorite) { create(:favorite_sitter, user: user, post_sitter: post) }

    it "投稿とユーザーが存在すれば保存される" do
      expect(favorite).to be_valid
    end

    it "一つの投稿に同じユーザーが2回以上保存できない" do
      favorite = build(:favorite_sitter, user: user, post_sitter: post)
      favorite.valid?
      expect(favorite.errors[:post_sitter_id])
    end

    it "投稿が空の場合は保存されない" do
      favorite = build(:favorite_sitter, post_sitter: nil)
      favorite.valid?
      expect(favorite.errors[:post_sitter]).to include("を入力してください")
    end

    it "ユーザーが空の場合は保存されない" do
      favorite = build(:favorite_sitter, user: nil)
      favorite.valid?
      expect(favorite.errors[:user]).to include("を入力してください")
    end
  end
end

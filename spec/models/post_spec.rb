require 'rails_helper'

RSpec.describe PostC, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe '#create' do
    it "全て入力されていれば登録できる" do
      post = build(:post_c)
      expect(post).to be_valid
    end

    it "タイトルが空の場合は登録できない" do
      post = build(:post_c, title: nil)
      post.valid?
      expect(post.errors[:title]).to include("が入力されていません。")
    end

    it "画像が空でも登録できる" do
      post = build(:post_c, image: nil)
      post.valid?
      expect(post).to be_valid
    end

    it "場所が空の場合は登録できない" do
      post = build(:post_c, region: nil)
      post.valid?
      expect(post.errors[:region]).to include("が入力されていません。")
    end

    it "日時が空の場合は登録できない" do
      post = build(:post_c, datetime: nil)
      post.valid?
      expect(post.errors[:datetime]).to include("が入力されていません。")
    end

    it "料金が空の場合は登録できない" do
      post = build(:post_c, price: nil)
      post.valid?
      expect(post.errors[:price]).to include("が入力されていません。")
    end

    it "支払い方法が空の場合は登録できない" do
      post = build(:post_c, payment: nil)
      post.valid?
      expect(post.errors[:payment]).to include("が入力されていません。")
    end

    it "リクエスト内容が空の場合は登録できない" do
      post = build(:post_c, content: nil)
      post.valid?
      expect(post.errors[:content]).to include("が入力されていません。")
    end
  end
end


RSpec.describe PostSitter, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe '#create' do
    it "全て入力されていれば登録できる" do
      post = build(:post_sitter)
      expect(post).to be_valid
    end

    it "タイトルが空の場合は登録できない" do
      post = build(:post_sitter, title: nil)
      post.valid?
      expect(post.errors[:title]).to include("が入力されていません。")
    end

    it "画像が空でも登録できる" do
      post = build(:post_sitter, image: nil)
      post.valid?
      expect(post).to be_valid
    end

    it "場所が空の場合は登録できない" do
      post = build(:post_sitter, region: nil)
      post.valid?
      expect(post.errors[:region]).to include("が入力されていません。")
    end

    it "日時が空の場合は登録できない" do
      post = build(:post_sitter, datetime: nil)
      post.valid?
      expect(post.errors[:datetime]).to include("が入力されていません。")
    end

    it "料金が空の場合は登録できない" do
      post = build(:post_sitter, price: nil)
      post.valid?
      expect(post.errors[:price]).to include("が入力されていません。")
    end

    it "支払い方法が空の場合は登録できない" do
      post = build(:post_sitter, payment: nil)
      post.valid?
      expect(post.errors[:payment]).to include("が入力されていません。")
    end

    it "リクエスト内容が空の場合は登録できない" do
      post = build(:post_sitter, content: nil)
      post.valid?
      expect(post.errors[:content]).to include("が入力されていません。")
    end
  end
end

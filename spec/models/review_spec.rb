require 'rails_helper'

RSpec.describe Review, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it "全てが入力されていれば保存できる" do
    review = build(:review)
    expect(review).to be_valid
  end

  it "レビュー内容が空の場合は保存できない" do
    review = build(:review, content: nil)
    review.valid?
    expect(review.errors[:content]).to include("が入力されていません。")
  end

  it "点数が空の場合は保存できない" do
    review = build(:review, rate: nil)
    review.valid?
    expect(review.errors[:rate]).to include("が入力されていません。")
  end

  it "評価する対象の立場が空の場合は保存できない" do
    review = build(:review, position: nil)
    review.valid?
    expect(review.errors[:position]).to include("が入力されていません。")
  end

  it "レビューされるユーザーが空の場合保存できない" do
    review = build(:review, reviewee_id: nil)
    review.valid?
    expect(review.errors[:reviewee_id])
  end

  it "レビューするユーザーが空の場合は保存できない" do
    review = build(:review, user_id: nil)
    review.valid?
    expect(review.errors[:user_id])
  end
end

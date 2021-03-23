require 'rails_helper'

RSpec.describe Relationship, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe '#create' do
    let(:follower) { create(:user) }
    let(:followed) { create(:user) }
    let(:relationship) { create(:relationship, follower: follower, followed: followed) }

    it "followerとfollowedが存在すれば保存される" do
      expect(relationship).to be_valid
    end

    it "同じfollowerとfollowedの組み合わせが2回以上保存されない" do
      relationship = build(:relationship, follower: follower, followed: followed)
      relationship.valid?
      expect(relationship.errors[:follower_id])
    end

    it "followerが空の場合は保存されない" do
      relationship = build(:relationship, follower: nil)
      relationship.valid?
      expect(relationship.errors[:follower]).to include("を入力してください")
    end

    it "followedが空の場合は保存されない" do
      relationship = build(:relationship, followed: nil)
      relationship.valid?
      expect(relationship.errors[:followed]).to include("を入力してください")
    end
  end
end

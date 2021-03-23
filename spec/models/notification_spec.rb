require 'rails_helper'

RSpec.describe Notification, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe '#create' do
    context "保存できる" do
      it "メッセージが送信されたら保存" do
        notification = build(:notification, action: "message")
        expect(notification).to be_valid
      end

      it "レビューが投稿されたら保存" do
        notification = build(:notification, action: "review")
        expect(notification).to be_valid
      end

      it "シッターの投稿がお気に入りに追加されたら保存" do
        notification = build(:notification, action: "favorite_c")
        expect(notification).to be_valid
      end

      it "シッター利用者の投稿がお気に入りに追加されたら保存" do
        notification = build(:notification, action: "favorite_sitter")
        expect(notification).to be_valid
      end

      it "ユーザーがフォローされたら保存" do
        notification = build(:notification, action: "follow")
        expect(notification).to be_valid
      end
    end

    context "保存できない" do
      it "actionが空の場合は保存されない" do
        notification = build(:notification, action: "")
        notification.valid?
        expect(notification.errors[:action])
      end

      it "actionの値が正しくない場合は保存されない" do
        notification = build(:notification, action: "comment")
        notification.valid?
        expect(notification.errors[:action])
      end

      it "通知の送信者が空の場合は保存されない" do
        notification = build(:notification, visitor: nil)
        notification.valid?
        expect(notification.errors[:visitor])
      end

      it "通知の受信者が空の場合は保存されない" do
        notification = build(:notification, visited: nil)
        notification.valid?
        expect(notification.errors[:visited])
      end

      it "checkedが空の場合は保存されない" do
        notification = build(:notification, checked: nil)
        notification.valid?
        expect(notification.errors[:checked])
      end
    end
  end
end

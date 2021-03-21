require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  before do
    @user = FactoryBot.build(:user)
  end

  describe '#create' do
    it "すべて入力されていれば登録できる" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "ユーザー名が空の場合は登録できない" do
      user = build(:user, username: nil)
      user.valid?
      expect(user.errors[:username]).to include("が入力されていません。")
    end

    it "メールアドレスが空の場合は登録できない" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("が入力されていません。")
    end

    it "メールアドレスに@とドメインが空の場合は登録できない" do
      user = create(:user)
      another_user = build(:user, email: "test1")
      another_user.valid?
      expect(another_user.errors[:email]).to include("は有効でありません。")
    end

    it "重複したメールアドレスが存在する場合は登録できない" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("は既に使用されています。")
    end

    it "パスワードが空である場合は登録できない" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("が入力されていません。")
    end

    it "パスワードが6文字以上であれば登録できる" do
      user = build(:user, password: "123456", password_confirmation: "123456")
      user.valid?
      expect(user).to be_valid
    end

    it "パスワードが5文字以下であれば登録できない" do
      user = build(:user, password: "12345", password_confirmation: "12345")
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上に設定して下さい。")
    end

    it "パスワード再入力が空の場合は登録できない" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("が内容とあっていません。")
    end

    it "パスワード再入力が空ではないが、パスワードと一致しない場合は登録できない" do
      user = build(:user, password: "123456", password_confirmation: "123457")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("が内容とあっていません。")
    end
  end
end

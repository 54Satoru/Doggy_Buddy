require 'rails_helper'

describe NotificationsController do
  let(:user) { create(:user) }
  let!(:notification) { create(:notification) }

  describe 'GET #index' do
    context "ユーザーがログインしている場合" do
      before do
        sign_in user
        get :index
      end

      it "通知一覧ページに遷移する" do
        expect(response).to render_template :index
      end

      it "HTTPのレスポンスが200である" do
        expect(response).to have_http_status "200"
      end
    end

    context "ユーザーがログインしていない場合" do
      before do
        get :index
      end

      it "ログイン画面にリダイレクトされる" do
        expect(response).to redirect_to new_user_session_path
      end

      it "HTTPのレスポンスが302である" do
        expect(response).to have_http_status "302"
      end
    end
  end

  describe 'DELETE #destroy' do
    subject do
      delete :destroy_all
    end

    context "ユーザーがログインしている場合" do
      before do
        sign_in user
      end

      it "通知を削除できる" do
        subject
        expect(response).to redirect_to notifications_path
      end
    end

    context "ユーザーがログインしていない場合" do
      it "ログイン画面にリダイレクトされる" do
        subject
        expect(response).to redirect_to new_user_session_path
      end

      it "HTTPのレスポンスが302である" do
        subject
        expect(response).to have_http_status "302"
      end
    end
  end
end

require 'rails_helper'

describe RoomsController do
  describe 'GET #index' do
    let(:user) { create(:user) }

    context "ユーザーがログインしている場合" do
      before do
        sign_in user
        get :index
      end

      it "トークルームのトップページに遷移する" do
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
end

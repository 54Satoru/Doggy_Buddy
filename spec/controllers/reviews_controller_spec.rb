require 'rails_helper'

describe ReviewsController do
  let(:user) { create(:user) }
  let(:current_user) { create(:user) }
  let(:review) { create(:review, reviewee: user) }
  describe 'GET #index' do
    context "ユーザーがログインしている場合" do
      before do
        sign_in user
        get :index, params: { user_id: user.id }
      end

      it "レビュー一覧ページに遷移する" do
        expect(response).to render_template :index
      end

      it "HTTPのレスポンスが200である" do
        expect(response).to have_http_status "200"
      end

      it "適切にインスタンス変数(@user)が取り出される" do
        expect(assigns(:user)).to eq user
      end
    end

    context "ユーザーがログインしていない場合" do
      before do
        get :index, params: { user_id: user.id }
      end

      it "レビュー一覧ページに遷移する" do
        expect(response).to render_template :index
      end

      it "HTTPのレスポンスが200である" do
        expect(response).to have_http_status "200"
      end
    end
  end

  describe 'GET #new' do
    context "ユーザーがログインしている場合" do
      before do
        sign_in user
        get :new, params: { user_id: user.id }
      end

      it "新規投稿ページに遷移する" do
        expect(response).to render_template :new
      end

      it "HTTPのレスポンスが200である" do
        expect(response).to have_http_status "200"
      end

      it "適切にインスタンス変数(@review)が取り出される" do
        expect(assigns(:review)).to be_a_new(Review)
      end
    end

    context "ユーザーがログインしていない場合" do
      before do
        get :new, params: { user_id: user.id }
      end

      it "ログイン画面にリダイレクトされる" do
        expect(response).to redirect_to new_user_session_path
      end

      it "HTTPのレスポンスが302である" do
        expect(response).to have_http_status "302"
      end
    end
  end

  describe 'POST #create' do
    let(:reviewee) { create(:user) }
    let(:review) { create(:review, reviewee: user) }
    let(:params) { { user_id: reviewee.id, review: attributes_for(:review, reviewee_id: reviewee) } }
    let(:user) { create(:user) }

    context "ユーザーがログインしている場合" do
      before do
        sign_in user
      end

      context "投稿が保存できない場合" do
        let(:invalid_params) { { user_id: user.id, review: attributes_for(:review, content: nil) } }

        subject do
          post :create,
               params: invalid_params
        end

        it "レビューが保存されない" do
          expect { subject }.not_to change(Review, :count)
        end

        it "新規レビュー投稿画面にリダイレクトされる" do
          subject
          expect(response).to render_template :new
        end
      end
    end
  end
end

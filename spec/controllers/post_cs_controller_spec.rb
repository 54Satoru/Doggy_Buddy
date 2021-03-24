require 'rails_helper'

describe PostCController do
  let(:user) { create(:user) }
  let(:current_user) { create(:user) }
  let(:post_c) { create(:post_c) }
  let(:review) { create_list(:review, 3) }
  let(:params) { { post_c: attributes_for(:post_c) } }

  describe 'GET #index' do
    let(:posts) { create_list(:post_c, 3) }

    before do
      get :index
    end

    it "投稿一覧ページに遷移する" do
      expect(response).to render_template :index
    end

    it "HTTPのレスポンスが200である" do
      expect(response).to have_http_status "200"
    end

    it "適切にインスタンス変数(@posts)が取り出される" do
      expect(assigns(:posts)).to match(posts.sort { |a, b| b.created_at <=> a.created_at })
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: { id: post_c }
    end

    it "投稿詳細ページに遷移する" do
      expect(response).to render_template :show
    end

    it "HTTPのレスポンスが200である" do
      expect(response).to have_http_status "200"
    end

    it "適切にインスタンス変数(@post)が取り出される" do
      expect(assigns(:post)).to eq post_c
    end
  end

  describe 'GET #new' do
    context "ユーザーがログインしている場合" do
      before do
        sign_in user
        get :new
      end

      it "新規投稿ページに遷移する" do
        expect(response).to render_template :new
      end

      it "HTTPのレスポンスが200である" do
        expect(response).to have_http_status "200"
      end

      it "適切にインスタンス変数(@post)が取り出される" do
        expect(assigns(:post)).to be_a_new(PostC)
      end
    end

    context "ユーザーがログインしていない場合" do
      before do
        get :new
      end

      it "ログイン画面にリダイレクトされる" do
        expect(response).to redirect_to new_user_session_path
      end

      it "HTTPのレスポンスが302である" do
        expect(response).to have_http_status "302"
      end
    end
  end

  describe 'GET #edit' do
    context "ユーザーがログインしている場合" do
      before do
        sign_in user
        get :edit, params: { id: post_c }
      end

      it "投稿編集ページに遷移する" do
        expect(response).to render_template :edit
      end

      it "HTTPのレスポンスが200である" do
        expect(response).to have_http_status "200"
      end

      it "適切にインスタンス変数(@post)が取り出される" do
        expect(assigns(:post)).to eq post_c
      end
    end

    context "ユーザーがログインしていない場合" do
      before do
        get :edit, params: { id: post_c }
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
    context "ユーザーがログインしている場合" do
      before do
        sign_in user
      end

      context "投稿が保存できる場合" do
        subject do
          post :create,
               params: params
        end

        it "投稿が保存される" do
          expect { subject }.to change(PostC, :count).by(1)
        end

        it "投稿詳細ページにリダイレクトされる" do
          subject
          expect(response).to redirect_to post_c_path(PostC.last)
        end
      end

      context "投稿が保存できない場合" do
        let(:invalid_params) { { post_c: attributes_for(:post_c, title: nil) } }

        subject do
          post :create,
               params: invalid_params
        end

        it "投稿が保存されない" do
          expect { subject }.not_to change(PostC, :count)
        end

        it "新規投稿ページにリダイレクトされる" do
          subject
          expect(response).to render_template :new
        end
      end
    end

    context "ユーザーがログインしていない場合" do
      subject do
        post :create,
             params: params
      end

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

  describe 'PATCH #update' do
    context "ユーザーがログインしている場合" do
      before do
        sign_in user
      end

      context "投稿が保存できる場合" do
        let(:params) { { title: "新しいタイトル" } }
        subject do
          patch :update,
                params: { id: post_c.id, post_c: params }
        end
        it "投稿が保存される" do
          subject
          expect(post_c.reload.title).to eq "新しいタイトル"
        end
      end

      context "投稿が保存できない場合" do
        let(:invalid_params) { { title: nil } }
        subject do
          patch :update,
                params: { id: post_c.id, post_c: invalid_params }
        end

        it "投稿編集ページにリダイレクトされる" do
          subject
          expect(response).to render_template :edit
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:post_c) { create(:post_c) }

    subject do
      delete :destroy,
             params: { id: post_c.id, post_c: params }
    end

    context "ユーザーがログインしている場合" do
      before do
        sign_in user
      end

      it "投稿を削除できる" do
        expect { subject }.to change(PostC, :count).by(-1)
      end
    end

    context "ユーザーがログインしていない場合" do
      it "投稿を削除できない" do
        expect { subject }.not_to change(PostC, :count)
      end
    end
  end
end

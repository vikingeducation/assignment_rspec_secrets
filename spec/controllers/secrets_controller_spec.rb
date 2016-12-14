require 'rails_helper'

describe SecretsController do
  let(:secret){ create(:secret) }
  let(:user){ secret.author }
  let(:another) {create(:secret)}

  before do
    secret
  end

  context 'authenticated paths' do
    before do
      session[:user_id] = user.id
    end

    describe "GET #new" do
      it 'renders the :new template' do
        process :new
        expect(response).to render_template(:new)
      end
    end

    describe "POST #create" do
      it 'creates a secret' do
        expect do
          process :create, params: { secret: attributes_for(:secret) }
        end.to change(Secret, :count).by(1)

      end

      it 'sets a flash message' do
        process :create, params: { secret: attributes_for(:secret) }

        expect(flash[:notice]).not_to be_nil
        expect(response).to redirect_to(secret_path(Secret.last))
      end

      it 'rerenders on bad params' do
        process :create, params: { secret: {title: ""}}

        expect(response).to render_template(:new)
      end
    end

    describe "GET #edit" do
      context 'with the correct user' do
        it 'shows the edit page' do
          process :edit, params: { id: secret.id }

          expect(response).to render_template :edit
        end
      end

      context 'without the correct user' do
        it 'raises an error' do

          expect do
            process :edit, params: { id: another.id }
          end.to raise_error ActiveRecord::RecordNotFound
        end
      end
    end

    describe "PATCH #update" do
      context 'with the correct user' do

        it "updates the secret" do
          before_update = secret
          process :update, method: :patch, params: { id: secret.id, secret: { body: "characters" } }
          secret.reload

          expect(secret.body).to eq("characters")
          expect(secret.title).to eq(before_update.title)

          expect(response).to redirect_to(secret_path(secret.id))
        end
      end

      context 'without the correct user' do
        it "raises a Not Found error" do

          expect do
            process :update, method: :patch, params: { id: another.id, secret: { body: "characters" } }
          end.to raise_error ActiveRecord::RecordNotFound

        end
      end
    end


    describe "DELETE #destroy" do
      context 'with the correct user' do

        it "deletes the secret" do
          before_update = secret
          expect do
            process :destroy, method: :delete, params: { id: secret.id }
          end.to change(Secret, :count).by(-1)

          expect(response).to redirect_to(secrets_path)
        end
      end

      context 'without the correct user' do
        it "raises a Not Found error" do

          expect do
            process :destroy, method: :delete, params: { id: another.id }
          end.to raise_error ActiveRecord::RecordNotFound

        end
      end
    end
  end

  context "Unauthenticated paths" do
    describe "GET #show" do
      it "properly sets @secret" do
        process :show, params: {id: secret.id}
        expect(assigns(:secret)).to eq(secret)
      end
    end

    describe "GET #index" do
      it "properly sets @secrets" do
        process :index
        expect(assigns(:secrets)).to match_array Secret.all
      end
    end

    describe "GET #new" do
      it 'redirects to login' do
        process :new
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

end

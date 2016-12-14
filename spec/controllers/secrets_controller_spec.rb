require 'rails_helper'

describe SecretsController do
  let(:secret){ create(:secret) }
  let(:user){ secret.author }

  before do
    secret
  end

  context 'authenticated paths' do
    before do
      session[:user_id] = user.id
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
          another = create(:user)
          session[:user_id] = another.id

          expect do
            process :edit, params: { id: secret.id }
          end.to raise_error ActiveRecord::RecordNotFound
        end
      end
    end

    describe "PATCH #update" do
      context 'with the correct user' do

      end

      context 'without the correct user' do

      end
    end

  end

  describe "GET #show" do
    it "properly sets @secret" do
      process :show, params: {id: secret.id}
      expect(assigns(:secret)).to eq(secret)
    end
  end

end

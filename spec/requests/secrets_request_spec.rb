require 'rails_helper'
describe 'SecretsRequests' do

  let(:user){ create(:user) }
  let(:new_secret){ create(:secret, author: user)}

  context 'Logged in User Requests' do

    before :each do
      post session_path, params: { email: user.email, password: user.password }
    end

    describe 'GET #index' do
      it 'is successful as root path' do
        get root_path
        expect(response).to be_success
      end

      it 'is successful' do
        get secrets_path
        expect(response).to be_success
      end
    end

    describe 'GET #new' do
      it 'is successful' do
        get new_secret_path
        expect(response).to be_success
      end

      it 'renders new form' do
        get new_secret_path
        expect(response).to render_template(:new)
      end
    end

    describe 'POST #create' do

      context 'with valid attributes' do

        it 'actually creates new secret' do
          expect { post secrets_path, params:
                                    { secret: attributes_for(:secret) }
                  }.to change(Secret, :count).by(1)
        end

        it 'creates flash message' do
          post secrets_path, params: { secret: attributes_for(:secret) }
          expect(flash[:success]).to_not be_nil
        end

        it 'redirects to show secret' do
          post secrets_path, params: { secret: attributes_for(:secret) }
          expect(response).to redirect_to(secret_path(user.secrets.last))
        end
      end

      context 'with invalid attributes' do
        it 'does not create secret' do
          expect { post secrets_path, params:
                                    { secret: attributes_for(:secret, title: nil) }
                  }.to change(User, :count).by(0)
        end

        it 'creates flash message' do
          post secrets_path, params: { secret: attributes_for(:secret, title: nil) }
          expect(flash).to_not be_nil
        end

        it 're-renders form' do
          post secrets_path, params: { secret: attributes_for(:secret, title: nil) }
          expect(response).to render_template(:new)
        end
      end
    end

    describe 'GET #edit' do
      it 'is successful' do
        get edit_secret_path(new_secret)
        expect(response).to be_success
      end
    end

    describe 'GET #show' do
      it 'is successful for own post' do
        get secret_path(new_secret)
        expect(response).to be_success
      end

      it 'is successful for another users post' do
        another_users_secret = create(:secret)
        get secret_path(another_users_secret)
        expect(response).to be_success
      end
    end

    describe 'PATCH #update' do

      context 'with valid inputs' do
        let(:secret_title) { "A Secret Title" }
        it 'actually updates secret' do
          put secret_path(new_secret), params: { secret: attributes_for(:secret, title: secret_title) }
          new_secret.reload
          expect(new_secret.title).to eq(secret_title)
        end
        it 'creates flash message' do
          put secret_path(new_secret), params: { secret: attributes_for(:secret, title: secret_title) }
          new_secret.reload
          expect(flash[:success]).to_not be_nil
        end
        it 'redirects you to show' do
          put secret_path(new_secret), params: { secret: attributes_for(:secret, title: secret_title) }
          new_secret.reload
          expect(response).to redirect_to(secret_path(new_secret))
        end
      end

      context 'with invalid inputs' do
        let(:invalid_title) { nil }
        it 'does not update secret' do
          put secret_path(new_secret), params: { secret: attributes_for(:secret, title: invalid_title) }
          new_secret.reload
          expect(new_secret.title).to_not eq(invalid_title)
        end
        it 'creates flash message' do
          put secret_path(new_secret), params: { secret: attributes_for(:secret, title: invalid_title) }
          new_secret.reload
          expect(flash).to_not be_nil
        end
        it 're-renders edit form' do
          put secret_path(new_secret), params: { secret: attributes_for(:secret, title: invalid_title) }
          new_secret.reload
          expect(response).to render_template(:edit)
        end
      end
    end

    describe 'DELETE #destroy' do
      before { user }
      before { new_secret }

      it 'actually deletes secret' do
        expect { delete secret_path(new_secret) }.to change(Secret, :count).by(-1)
      end

    end
  end

  context 'Not logged in User Requests' do

    describe 'GET #new' do
      it 'redirects you to log in page' do
        get new_secret_path
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe 'GET #index' do
      it 'is successful as normal' do
        get secrets_path
        expect(response).to be_success
      end
    end

    describe 'GET #show' do
      it 'is successful as normal' do
        get secret_path(new_secret)
        expect(response).to be_success
      end
    end

  end

end

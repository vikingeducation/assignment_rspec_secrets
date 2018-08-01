require 'rails_helper'

describe 'UsersRequests' do
  describe 'User access' do

    let(:user){ create(:user) }
    let(:another_user){ create(:user) }

    before :each do
      post session_path, params: { email: user.email, password: user.password }
    end

    describe 'GET #new' do
      it 'is successful when logged in' do
        get new_user_path
        expect(response).to be_success
      end
    end

    describe 'GET #index' do
      it 'is successful when logged in' do
        get users_path
        expect(response).to be_success
      end
    end

    describe 'GET #show' do
      it 'is successful when user is logged in' do
        get user_path(user)
        expect(response).to be_success
      end

      it 'is successful for another user' do
        get user_path(another_user)
        expect(response).to be_success
      end
    end

    describe 'GET #edit' do
      it 'is successful when user is logged in' do
        get edit_user_path(user)
        expect(response).to be_success
      end

      it 'for another user is not successful' do
        get edit_user_path(another_user)
        expect(response).to redirect_to root_path
      end
    end

    describe 'POST #create' do
      it 'actually creates new user' do
        expect { post users_path, params:
                                  { user: attributes_for(:user) }
                }.to change(User, :count).by(1)
      end

      it 'redirects after creating user' do
        post users_path, params: { user: attributes_for(:user) }
        expect(response).to have_http_status(:redirect)
      end

      it 'creates flash message' do
        post users_path, params: { user: attributes_for(:user) }
        expect(flash[:success]).to_not be_nil
      end
    end

    describe 'PATCH #update' do
      context 'with valid attributes' do

        let(:updated_name){ "Updated Name" }

        it 'actually updates user' do
          put user_path(user), params: { user: attributes_for(:user, name: updated_name) }
          user.reload
          expect(user.name).to eq(updated_name)
        end

        it 'creates flash message' do
          put user_path(user), params: { user: attributes_for(:user, name: updated_name) }
          user.reload
          expect(flash[:success]).to_not be_nil
        end

        it 'redirects after update' do
          put user_path(user), params: { user: attributes_for(:user, name: updated_name) }
          user.reload
          expect(response).to have_http_status(:redirect)
        end
      end

      context 'without valid attributes' do
        it 'does not update user' do
          put user_path(user), params: { user: attributes_for(:user, name: nil) }
          user.reload
          expect(user.name).to eq(user.name)
        end
        it 'renders form again' do
          put user_path(user), params: { user: attributes_for(:user, name: nil) }
          user.reload
          expect(subject).to render_template(:edit)
        end
        it 'creates flash message' do
          put user_path(user), params: { user: attributes_for(:user, name: nil) }
          user.reload
          expect(flash).to_not be_nil
        end
      end
    end

    describe 'DELETE #destroy' do
      before { user }
      before { another_user }

      it 'actually destroys user' do
        expect { delete user_path(user) }.to change(User, :count).by(-1)
      end

      it 'for another user does not destroy user' do
        expect { delete user_path(another_user) }.to change(User, :count).by(0)
      end

      it 'for another user redirects to root path' do
        delete user_path(another_user)
        expect(response).to redirect_to root_path
      end
    end

  end
end

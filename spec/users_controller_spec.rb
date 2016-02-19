# spec/controllers/users_controller_spec.rb
require 'rails_helper'

describe UsersController do
  describe 'user access' do
    let(:user){ create(:user) }

    # Log in the easy way -- we have access
    # to the `session` and `cookies` hashes here!
    before :each do

      # If we did session-based auth, we'd use this:
      # session[:user_id] = user.id

      # Since this example uses cookie-based auth
      # we add to the cookies sent in with the response
      # to contain our authenticity token
      request.cookies["auth_token"] = user.auth_token
    end

    describe 'GET #index' do
      it "collects users into @users" do
        another_user = create(:user)

        # Make the actual request using the specified
        # HTTP verb and action
        get :index

        # A typical expectation
        # Here we're using `assigns` to verify that the
        # instance variable is being set
        # `assigns` returns that variable
        # Note that `match_array` is helpful because 
        #   the order of items doesn't matter.
        expect(assigns(:users)).to match_array [user,another_user]
      end

      it "renders the :index template" do
        get :index

        # We can check which view template is being rendered
        expect(response).to render_template :index
      end
    end

    it "GET #new works as normal" do
      get :new
      expect(response).to render_template :new
    end

    describe "POST #create" do
      it "redirects to the new user" do

        # Send in the attributes of a user (from our factory)
        #   as if we'd submitted them in a `form_for` form
        post :create, :user => attributes_for(:user)

        # Now expect a redirect instead of a render
        # AND we'll utilize our newly-assigned instance
        # variable to make sure we get to the right user
        expect(response).to redirect_to user_path(assigns(:user))
      end

      # Note that this isn't being mocked out
      # so if you're following a mock approach (which
      # is really best), the above example is better
      # (and simpler as well)
      it "actually creates the user" do
        expect{
          post :create, user: attributes_for(:user)
        }.to change(User, :count).by(1)
      end
    end

    describe "GET #edit" do
      it "for this user works as normal" do
        get :edit, :id => user.id
        expect(response).to render_template :edit
      end

      it "for another user denies access" do

        # make sure this user actually exists
        another_user = create(:user)
        get :edit, :id => another_user.id

        expect(response).to redirect_to root_url
      end
    end

    describe "PATCH #update" do

      # Do this nudge to make sure our `let` user actually
      # gets called before the tests to ensure that user
      # is persisted.  Otherwise, it might not persist 
      # until midway through or after a test.  This is lazy
      # `let(:user)` doing its job.  We could have switched
      # to eager `let!(:user)` above but... don't feel like it.
      # Also, this may not be relevant since our login in
      # the top-level `before` block will force the user to
      # evaluate, but we might change that later and don't
      # want our whole test to blow up.
      before { user }

      context "with valid attributes" do

        let(:updated_name){ "updated_foo" }

        # let's make sure the ID parameter works
        it "finds the specified user" do
          put :update, :id => user.id,
                        :user => attributes_for(:user, 
                                                :name => updated_name)
          expect(assigns(:user)).to eq(user)
        end

        it "redirects to the updated user" do
          # Send in the attributes of a user 
          # with a different name
          put :update, :id => user.id,
                        :user => attributes_for(:user, 
                                                :name => updated_name)

          expect(response).to redirect_to user_path(assigns(:user))
        end

        # Note that this isn't being mocked out
        it "actually updates the user" do
          put :update, :id => user.id,
                        :user => attributes_for(:user, 
                                                :name => updated_name)
          # This won't work properly if you don't reload!!!
          # The user in that case would be the same one
          # you set in the `let` method
          user.reload
          expect(user.name).to eq(updated_name)
        end
      end

      context "with invalid attributes" do
        # ...and so on
      end
    end

    describe "DELETE #destroy" do

      before { user }  # force let to evaluate

      it "destroys the user" do
        expect{
          delete :destroy, :id => user.id
        }.to change(User, :count).by(-1)
      end

      it "redirects to the root" do
        delete :destroy, :id => user.id
        expect(response).to redirect_to root_url
      end
      # ... and so on
    end
    # ... and so on
  end
end
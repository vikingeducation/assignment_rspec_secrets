# spec/controllers/users_controller_spec.rb
require 'rails_helper'

describe SecretsController do

  describe 'user access' do
    let(:user){ create(:user) }
    let(:secret){ create(:secret, author: user) }


    before :each do

      session[:user_id] = user.id

    end


    describe 'GET #show' do
      it "shows secret" do

        get :show, id: secret.id
        expect(assigns(:secret)).to match secret
      end
 
    end

    describe 'GET #new' do
      it "new secret" do

        get :new
        expect(assigns(:secret)).to be_a_new(Secret)
      end
 
    end

    describe 'POST #create' do
      it "creates a secret" do

        expect {post :create, secret: attributes_for(:secret)
               }.to change(Secret, :count).by(1)
      end
 
    end

    describe 'POST #create redirects to show' do
      it "redirects after secret secret" do

        post :create, secret: attributes_for(:secret)
        expect(response).to redirect_to secret_path(assigns(:secret))      
      end
 
    end

    describe 'POST #create creates a flash message for success' do
      it "creates a success flash message" do

        post :create, secret: attributes_for(:secret)
        expect(request.flash[:notice]).to_not be_nil
      end
 
    end

    describe 'POST #create creates a flash message for failure' do
      it "creates a failure flash message" do

        post :create, secret: attributes_for(:secret, body: "x")
        expect(response).to render_template :new
      end
 
    end


    describe 'GET #edit' do
      it "edit secret" do

        secret
     
        get :edit, id: secret.id
        expect(assigns(:secret).id).to eq secret.id
      end
 
    end

   describe 'POST #updates redirects to show' do
      it "redirects after secret update" do

        put :update, id: secret.id, secret: attributes_for(:secret, body: "New Body")
        expect(response).to redirect_to secret_path(assigns(:secret))      
      end
 
    end

   describe 'POST #updates redirects to show' do
      it "redirects after secret update" do

        put :update, id: secret.id, secret: attributes_for(:secret, body: "New Body")
        secret.reload
        expect(secret.body).to eq "New Body"     
      end
 
    end

  end

end

    #   it "renders the :index template" do
    #     get :index

    #     # We can check which view template is being rendered
    #     expect(response).to render_template :index
    #   end
    # end

    # describe 'GET #index' do
    #   it "collects users into @users" do
    #     another_user = create(:user)

    #     # Make the actual request using the specified
    #     # HTTP verb and action
    #     get :index

    #     # A typical expectation
    #     # Here we're using `assigns` to verify that the
    #     # instance variable is being set
    #     # `assigns` returns that variable
    #     # Note that `match_array` is helpful because 
    #     #   the order of items doesn't matter.
    #     expect(assigns(:users)).to match_array [user,another_user]
    #   end

    #   it "renders the :index template" do
    #     get :index

    #     # We can check which view template is being rendered
    #     expect(response).to render_template :index
    #   end
    # end

    # it "GET #new works as normal" do
    #   get :new
    #   expect(response).to render_template :new
    # end

    # describe "POST #create" do
    #   it "redirects to the new user" do

    #     # Send in the attributes of a user (from our factory)
    #     #   as if we'd submitted them in a `form_for` form
    #     post :create, :user => attributes_for(:user)

    #     # Now expect a redirect instead of a render
    #     # AND we'll utilize our newly-assigned instance
    #     # variable to make sure we get to the right user
    #     expect(response).to redirect_to user_path(assigns(:user))
    #   end

    #   # Note that this isn't being mocked out
    #   # so if you're following a mock approach (which
    #   # is really best), the above example is better
    #   # (and simpler as well)
    #   it "actually creates the user" do
    #     expect{
    #       post :create, user: attributes_for(:user)
    #     }.to change(User, :count).by(1)
    #   end
    # end

    # describe "GET #edit" do
    #   it "for this user works as normal" do
    #     get :edit, :id => user.id
    #     expect(response).to render_template :edit
    #   end

    #   it "for another user denies access" do

    #     # make sure this user actually exists
    #     another_user = create(:user)
    #     get :edit, :id => another_user.id

    #     expect(response).to redirect_to root_url
    #   end
    # end

    # describe "PATCH #update" do

    #   # Do this nudge to make sure our `let` user actually
    #   # gets called before the tests to ensure that user
    #   # is persisted.  Otherwise, it might not persist 
    #   # until midway through or after a test.  This is lazy
    #   # `let(:user)` doing its job.  We could have switched
    #   # to eager `let!(:user)` above but... don't feel like it.
    #   # Also, this may not be relevant since our login in
    #   # the top-level `before` block will force the user to
    #   # evaluate, but we might change that later and don't
    #   # want our whole test to blow up.
    #   before { user }

    #   context "with valid attributes" do

    #     let(:updated_name){ "updated_foo" }

    #     # let's make sure the ID parameter works
    #     it "finds the specified user" do
    #       put :update, :id => user.id,
    #                     :user => attributes_for(:user, 
    #                                             :name => updated_name)
    #       expect(assigns(:user)).to eq(user)
    #     end

    #     it "redirects to the updated user" do
    #       # Send in the attributes of a user 
    #       # with a different name
    #       put :update, :id => user.id,
    #                     :user => attributes_for(:user, 
    #                                             :name => updated_name)

    #       expect(response).to redirect_to user_path(assigns(:user))
    #     end

    #     # Note that this isn't being mocked out
    #     it "actually updates the user" do
    #       put :update, :id => user.id,
    #                     :user => attributes_for(:user, 
    #                                             :name => updated_name)
    #       # This won't work properly if you don't reload!!!
    #       # The user in that case would be the same one
    #       # you set in the `let` method
    #       user.reload
    #       expect(user.name).to eq(updated_name)
    #     end
    #   end

    #   context "with invalid attributes" do
    #     # ...and so on
    #   end
    # end

    # describe "DELETE #destroy" do

    #   before { user }  # force let to evaluate

    #   it "destroys the user" do
    #     expect{
    #       delete :destroy, :id => user.id
    #     }.to change(User, :count).by(-1)
    #   end

    #   it "redirects to the root" do
    #     delete :destroy, :id => user.id
    #     expect(response).to redirect_to root_url
    #   end
    #   # ... and so on
    # end
    # ... and so on
#   end
# end
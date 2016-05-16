require 'rails_helper'

describe SecretsController do

  let(:user){ create(:user) }
  let(:secret){ user.secrets.create(attributes_for(:secret)) }

  context "user is not signed_in" do
    describe "get #index" do
      it "sets @secrets" do
        new_secret = create(:secret)
        get :index

        expect(assigns(:secrets)).to match_array([new_secret,secret])
      end

      it "only returns 5 secrets even if there are more than 5 secrets" do
        create_list(:secret, 10)
        get :index

        expect(assigns(:secrets).size).to eq(5)
      end
      # I feel like any more tests on the returned array should be done on the model level.

      # This could be unnecessary as it's just expected to render that template (e.g. are we testing a rails function)
      it 'renders the :index template' do
        get :index

        expect(response).to render_template(:index)
      end
    end

    describe "get #show" do
      it "sets @secret" do
        get :show, :id => secret.id

        expect(assigns(:secret)).to eq(secret)
      end
    end
  end

  context "user is signed in" do
    before do
      session[:user_id] = user.id
    end

    describe "get #new" do
      it "sets @secret as a new Secret" do
        get :new

        expect(assigns(:secret)).to be_a_new(Secret)
      end
    end

    describe "get #edit" do
      it "sets @secret" do
        get :edit, :id => secret.id

        expect(assigns(:secret)).to eq(secret)
      end
    end

    describe "post #create" do
      it "sets @secret" do
        post :create, :secret => attributes_for(:secret)

        # The @secret would be saved and it would become the user's latest secret...
        expect(assigns(:secret)).to eq(user.secrets.last)
      end

      it "redirects to the secret's show page if secret is saved" do
        post :create, :secret => attributes_for(:secret)

        expect(response).to redirect_to(user.secrets.last)
      end

      it "renders the new page if secret is not saved" do
        post :create, :secret => {:fail => "Mega Fail"}

        expect(response).to render_template(:new)
      end
    end

    describe "patch #update" do
      let(:new_title){ "New Title" }
      let(:new_body){ "New Body" }
      let(:fail_title){ "" }
      it "sets @secret" do
        patch :update, :id => secret.id, :secret => {:title => new_title, :body => new_body}

        expect(assigns(:secret)).to eq(secret)
      end

      it "redirects to the updated secret's show page if update successful" do
        patch :update, :id => secret.id, :secret => {:title => new_title, :body => new_body}

        expect(response).to redirect_to(secret)
      end

      it "renders the edit page if update fails" do
        patch :update, :id => secret.id, :secret => {:title => fail_title, :body => new_body}

        expect(response).to render_template(:edit)
      end

      it "updates the title" do
        patch :update, :id => secret.id, :secret => {:title => new_title, :body => "Body"}

        secret.reload
        expect(secret.title).to eq(new_title)
      end

      it "updates the body" do
        patch :update, :id => secret.id, :secret => { :title => new_title, :body => new_body }

        secret.reload
        expect(secret.body).to eq(new_body)
      end
    end

    describe "delete #destroy" do
      it "sets @secret" do
        delete :destroy, :id => secret.id

        expect(assigns(:secret)).to eq(secret)
      end

      it "deletes the secret" do
        secret
        expect{
          delete :destroy, :id => secret.id
        }.to change(Secret, :count).by(-1)
      end

      it "redirects to secrets_url" do
        delete :destroy, :id => secret.id

        expect(response).to redirect_to(secrets_url)
      end
    end
  end

end
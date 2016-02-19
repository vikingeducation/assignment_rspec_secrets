require 'rails_helper.rb'

describe SecretsController do

  let(:user) { create(:user) }
  let(:secret) { create(:secret, author: user)}
  context "Visitor" do

    describe "GET #show" do

      it "renders the correct secret properly" do
        get :show, id: secret
        expect(response).to render_template :show
      end
    end
    
    describe "PATCH #update" do
      it "can't update others secrets" do
        new_title = "valid title"
        put :update, { id: secret.id, :secret => attributes_for( :secret, title: new_title )}
        secret.reload
        expect(secret.title).to_not eq(new_title)
      end
    end

  end 

  context "Logged In User" do

    let(:user_2) { create(:user)}
    let(:secret_2) { create(:secret, author: user_2) }

    describe "POST #create" do

      it "can make new secret" do
        post :create, {:secret => attributes_for( :secret )}, { user_id: user.id }
        # new_secret = assigns( :secret ).reload
        expect(response).to redirect_to( secret_path( assigns( :secret ) ) )
      end

      it "upon creation, sets flash success message" do
        post :create, {:secret => attributes_for( :secret )}, { user_id: user.id }
        expect(flash[:notice]).to_not be(nil)
      end

      it "reredners new template on invalidated secret" do
        post :create, { secret: { title: "", body: "" } }, { user_id: user.id }
        expect(response).to render_template( :new )
      end

    end

    describe "GET #edit" do

      it "can send GET request to edit form for user's own secrets" do
        get :edit, { id: secret.id }, { user_id: user.id }
        expect(response).to render_template( :edit )
      end

      it "cannot edit other's secrets" do
        expect do
          get :edit, { id: secret_2.id }, { user_id: user.id }
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    describe "PATCH #update" do
      it "can send POST request to update method for user's own secrets" do
        new_title = "valid title"
        put :update, { id: secret.id, :secret => attributes_for( :secret, title: new_title )},  { user_id: user.id }
        secret.reload
        expect(secret.title).to eq(new_title)
      end
    end

    describe "DELETE #destroy" do
      it "can delete method for user's own secrets" do
        delete :destroy, { id: secret.id }, { user_id: user.id }
        expect(response).to redirect_to( secrets_path )
      end
 
    end

  end
 
end
 
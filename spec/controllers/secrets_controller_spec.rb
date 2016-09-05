require 'rails_helper'


describe SecretsController do 

  let(:user) {create(:user)}
  let(:user_secret){ create(:secret, author: user) }

  describe "secrets access" do

    describe "get #show" do

      it "sets the correct instance variable" do
        get :show, id: user_secret.id
        expect(assigns(:secret)).to eq(user_secret)

      end

    end

  end#end secret access

  context "signed in user" do
    before :each do 
      session[:user_id] = user.id
      user
    end

    context "a user wants to create a secret" do 
      describe "post #create" do
        it "is able to create a secret when a user is logged in" do
          expect { post :create, :secret => attributes_for(:secret)}.to change(Secret, :count).by(1)
          expect(response).to redirect_to secret_path(assigns(:secret))
        end



      end #end post create


    end #end a user wants to create a secret



  

    context "a user has a secret" do
      
      let(:another_user){create(:user)}
      let(:other_secret){create(:secret, author: another_user)}

      describe "get #edit" do

        describe "while editing the current user" do
          before {get :edit, :id => user_secret.id}

          it "a user is able to edit a secret that belongs to them" do
            expect(response).to render_template :edit
          end

          it "sets the proper instance variable" do
            expect(assigns(:secret)).to eq(user_secret)

          end
        end #while editing

        it "is unable to edit a secret that belongs to another" do
          expect{ get :edit, :id => other_secret.id}.to raise_error
        end

      end #end get #edit

      describe "delete #destroy" do
        before { user_secret }
        it "a user is able to destroy a secret that belongs to them" do
          expect{ delete :destroy, id: user_secret.id}.to change(Secret, :count).by(-1)
          expect(response).to redirect_to(secrets_path)
        end

        it "is unable to destroy a secret that belongs to another" do
          expect{ delete :destroy, id: other_secret.id}.to raise_error

        end

      end #delete destroy

    end #end a user has a secret


  end#end context signed in user




end
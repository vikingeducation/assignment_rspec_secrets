require 'rails_helper'

describe SecretsController do
  let(:secret) { create(:secret) }
  let(:user) { secret.author }

  before do
    session[:user_id] = user.id
  end

    describe "DELETE #destroy" do

      before { secret }

      context "valid user's secret" do
        it "can be destroyed" do
          expect {
            process :destroy, params: { id: secret.id }
          }.to change(Secret, :count).by(-1)
        end
      end

      context "not user's secret" do
        let(:new_user) { create(:user) }

        before do
          user
          session[:user_id] = new_user.id
        end

        it "can't be destroyed" do
          expect {
            process :destroy, params: { id: secret.id }
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end

    end


end

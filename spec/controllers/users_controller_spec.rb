require 'rails_helper'

describe UsersController do

  describe 'user#create' do

    let(:user) { create(:user) }

    context 'valid parameters' do
      it 'creates a user given' do

        expect{
          process :create, params: { user: attributes_for(:user) }
        }.to change(User, :count).by(1)

      end
    end

    context 'invalid parameters' do
      it 'creates a user given' do

        expect{
          process :create, params: { user: attributes_for(:user, :bogus_params) }
        }.not_to change(User, :count)
      end

    end

  end

end
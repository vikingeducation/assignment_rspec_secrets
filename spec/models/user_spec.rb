require 'rails_helper'

describe User do

  # --------------------------------------------
  # Initialization
  # --------------------------------------------
  describe '#initialize' do
    it 'returns an instance of the User class' do
      user = build(:user)
      expect(user).to be_an_instance_of(User)
    end
  end

  # --------------------------------------------
  # Validations
  # --------------------------------------------
  describe 'validations of' do
    let(:user){build(:user)}

    describe '#name' do
      it 'fails when not present' do
        user.name = ''
        expect {user.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'passes when present and within a length of 3..20 chars' do
        expect {user.save!}.to_not raise_error
      end

      it 'fails when less than 2 chars' do
        user.name = 'a'
        expect {user.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'fails when more than 20 chars' do
        user.name = '123456789012345678901'
        expect {user.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    describe '#email' do
      it 'fails when not present' do
        user.email = ''
        expect {user.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'passes when present' do
        expect {user.save!}.to_not raise_error
      end

      it 'fails when not unique' do
        already_saved_user = create(:user, :email => 'foo@bar.com')
        new_user = build(:user, :email => 'foo@bar.com')
        expect {new_user.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'passes when is unique' do
        expect {user.save!}.to_not raise_error
      end
    end

    describe '#password' do
      it 'fails when less than 6 chars' do
        new_user = build(:user, :password => '12345')
        expect {new_user.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'fails when more than 16 chars' do
        new_user = build(:user, :password => '12345678123456781')
        expect {new_user.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'passes when between 6..16 chars' do
        expect {user.save!}.to_not raise_error
      end
    end
  end

  # --------------------------------------------
  # Associations
  # --------------------------------------------
  describe 'association with' do
    let(:user){create(:user)}

    before do
      2.times {user.secrets.create(attributes_for(:secret))}
    end

    describe '#secrets' do
      it 'returns all secrets belonging to this user (no more no less)' do
        expect(user.secrets.length).to eq(2)
      end

      it 'returns values that are of type Secret' do
        expect(user.secrets.first).to be_an_instance_of(Secret)
      end
    end
  end
end





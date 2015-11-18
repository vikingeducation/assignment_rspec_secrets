require 'rails_helper'

describe User do

  describe '#initialize' do
    it 'should return an instance of the User class' do
      user = build(:user)
      expect(user).to be_an_instance_of(User)
    end
  end

  describe 'validations of' do
    let(:user){build(:user)}

    describe '#name' do
      it 'should fail when not present' do
        user.name = ''
        expect {user.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'should pass when present and within a length of 3..20 chars' do
        expect {user.save!}.to_not raise_error
      end

      it 'should fail when less than 2 chars' do
        user.name = 'a'
        expect {user.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'should fail when more than 20 chars' do
        user.name = '123456789012345678901'
        expect {user.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    describe '#email' do
      it 'should fail when not present' do
        user.email = ''
        expect {user.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'should pass when present' do
        expect {user.save!}.to_not raise_error
      end

      it 'should fail when not unique' do
        already_saved_user = create(:user, :email => 'foo@bar.com')
        new_user = build(:user, :email => 'foo@bar.com')
        expect {new_user.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'should pass when is unique' do
        expect {user.save!}.to_not raise_error
      end
    end

    describe '#password' do
      it 'should fail when less than 6 chars' do
        new_user = build(:user, :password => '12345')
        expect {new_user.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'should fail when more than 16 chars' do
        new_user = build(:user, :password => '12345678123456781')
        expect {new_user.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'should pass when between 6..16 chars' do
        expect {user.save!}.to_not raise_error
      end
    end
  end

  describe 'association with' do
    let(:user){create(:user)}

    before do
      2.times {user.secrets.create(attributes_for(:secret))}
    end

    describe '#secrets' do
      it 'should return all secrets belonging to this user (no more no less)' do
        expect(user.secrets.length).to eq(2)
      end

      it 'should return values that are of type Secret' do
        expect(user.secrets.first).to be_an_instance_of(Secret)
      end
    end
  end
end





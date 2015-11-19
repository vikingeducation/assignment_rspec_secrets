require 'rails_helper'

describe Secret do

  # --------------------------------------------
  # Initialization
  # --------------------------------------------
  describe '#initialize' do
    it 'should return an instance of the Secret class' do
      secret = build(:secret)
      expect(secret).to be_an_instance_of(Secret)
    end
  end

  # --------------------------------------------
  # Validations
  # --------------------------------------------
  describe 'validations of' do
    let(:secret){build(:secret)}

    describe '#title' do
      it 'should pass when present' do
        expect {secret.save!}.to_not raise_error
      end

      it 'should fail when not present' do
        secret.title = ''
        expect {secret.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'should pass when length is between 4..24' do
        expect {secret.save!}.to_not raise_error
      end

      it 'should fail when length less than 4' do
        secret.title = '123'
        expect {secret.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'should fail when length more than 24' do
        secret.title = '-' * 25
        expect {secret.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    describe '#body' do
      it 'should fail when not present' do
        secret.body = ''
        expect {secret.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'should pass when present' do
        expect {secret.save!}.to_not raise_error
      end

      it 'should pass when between 2..140' do
        expect {secret.save!}.to_not raise_error
      end

      it 'should fail when less than 2' do
        secret.body = '1'
        expect {secret.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'should fail when more than 140' do
        secret.body = '-' * 141
        expect {secret.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    describe '#author' do
      it 'should fail when not present' do
        secret.author = nil
        expect {secret.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'should pass when present' do
        expect {secret.save!}.to_not raise_error
      end
    end
  end

  # --------------------------------------------
  # Associations
  # --------------------------------------------
  describe 'association with' do
    let(:user){create(:user)}
    let(:secret){create(:secret, :author => user)}

    describe '#author' do
      it 'should return the author (user) to which the secret belongs' do
        expect(secret.author_id).to eq(user.id)
      end
    end
  end

  # --------------------------------------------
  # Class Methods
  # --------------------------------------------
  describe 'class methods' do
    let!(:user){create(:user)}
    let!(:secrets) do
      10.times {create(:secret, :author => user)}
    end

    describe '#last_five' do
      it 'should return only 5 secrets' do
        last_five = Secret.last_five
        expect(last_five.length).to eq(5)
      end

      it 'should return only the most recently created secrets' do
        last_five = Secret.last_five.pluck(:id)
        most_recent_five = Secret.order(:id => :desc).limit(5).pluck(:id)
        expect(last_five).to eq(most_recent_five)
      end
    end
  end
end




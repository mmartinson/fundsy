require 'rails_helper'

RSpec.describe User, :type => :model do

  describe "Validations" do 
    it "is invalid without an email" do
      user = User.new(first_name: "Tam", last_name: "Kbeili")
      expect(user).to be_invalid
    end

    it 'rejects users with invalid email' do
      user = User.new(email: "not an email")
      user.save
      expect(user.errors.messages).to have_key(:email)
    end
  end

  describe "#full_name" do
    it 'gives concatenated first_name and last_name' do
      user = User.new(first_name: 'Tam', last_name: 'Kbeili')
      expect(user.full_name).to eq("Tam Kbeili")
    end

    it 'gives and email if first_name and last_name are not provided' do
      user = User.new(email: "tam@codecore.com")
      expect(user.full_name).to eq("tam@codecore.com")
    end

    it 'gives either first_name or last_name if only one is provided' do
      user = User.new(first_name: 'Tam', email: "tam@codecore.com")
      expect(user.full_name).to eq("Tam")
    end

    describe "hashing the password" do
      let(:user) {FactoryGirl.build(:user)}
      it 'generates password digest when given matching password and password_confirmation' do
        user.password = "gg1122"
        user.password_confirmation = "gg1122"
        expect(user.password_digest).to be
      end
    end

    describe 'callbasks' do
      let(:user) {FactoryGirl.build(:user)}

      describe 'capitalizing name' do
        it 'capitalizes first name before saving' do
          user.first_name = 'tam'
          user.save
          expect(user.first_name).to eq("Tam")
        end
      end
    end
  end
end

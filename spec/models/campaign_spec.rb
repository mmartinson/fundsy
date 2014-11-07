require 'rails_helper'

RSpec.describe Campaign, :type => :model do
  describe "validations" do
    def valid_attr
      attributes_for :campaign
    end

    let(:campaign) {build(:campaign)}

    it 'requires a title' do
      campaign.title = nil
      expect(campaign).to_not be_valid
    end

    it "requires a description" do
       campaign.description = nil
       campaign.save
       expect(campaign.errors.messages).to have_key(:description) 
    end

    it 'requires a goal that is $10 or more' do
      campaign.goal = 3
      expect(campaign).to_not be_valid
    end

    it "requires a deadline" do
      campaign.deadline = nil
      expect(campaign).to_not be_valid
    end

    it 'requires deadline to be at least one hour in the future' do
      campaign.deadline = Time.new+59.minutes
      expect(campaign).to_not be_valid
    end

    it "requires a user" do
      #fix this when adding sessions controller
      expect(campaign).to be_valid
    end
  end
end

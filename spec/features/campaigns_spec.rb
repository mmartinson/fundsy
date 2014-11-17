require 'rails_helper'

feature 'Campaigns', type: :feature do
  let(:user) {create(:user)}
  describe "Listing campaigns" do
    it 'displays a welcome message' do
      visit campaigns_path
      expect(page).to have_text "Welcome to Fund.sy"
    end

    it 'displays a title for the page' do
      visit campaigns_path
      expect(page).to have_title("Fund.sy")
    end

    context 'with campaigns' do
      let!(:campaign) {create(:campaign)}
      let!(:campaign1) {create(:campaign)}

      it 'displays campaign titles' do
        visit campaigns_path
        expect(page).to have_text /#{campaign.title}/i
      end

      it 'displays campaign titles within h2 elements' do
        visit campaigns_path
        expect(page).to have_selector "h2", campaign1.title
      end
    end
  end

  describe "Creating a campaign" do
    it 'creates a campaign and redirects to show page' do
      #first log in, from method in support file
      login_via_webpage(user)
      visit new_campaign_path
      attributes = attributes_for(:campaign)
      fill_in "Title", with: attributes[:title]
      fill_in "Description", with: attributes[:description]
      fill_in "Goal", with: attributes[:goal]
      fill_in "Deadline", with: attributes[:deadline]

      expect(current_path).to eq(campaign_path(Campaign.last))
      expect(Campaign.count).to eq(1)
      expect(page).to have_content /Campaign saved!/i

    end
  end
end
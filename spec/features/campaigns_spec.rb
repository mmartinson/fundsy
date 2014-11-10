require 'rails_helper'

feature 'Campaigns', type: :feature do
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
        save_and_open_page
        expect(page).to have_selector "h2", campaign1.title
      end
    end
  end
end
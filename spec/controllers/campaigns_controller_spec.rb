require 'rails_helper'

RSpec.describe CampaignsController, :type => :controller do
  let(:user) {create(:user)}
  let(:campaign) {create(:campaign, user: user)}
  let(:campaign_1) {create(:campaign, user: user)}


  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns all campaigns to a variable' do
      campaign
      campaign_1
      get :index
      expect(assigns(:campaigns)).to eq([campaign, campaign_1])
    end

    it 'renders index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "Assigns a new campaign to a variable" do
      get :new
      expect(assigns(:campaign)).to be_a_new(Campaign)
    end

    it "Renders a new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST create" do
    context "With valid campaign params" do
      def valid_request
        post :create, {campaign: attributes_for(:campaign)}
      end

      it "saves record to the db" do
        expect{valid_request}.to change{Campaign.count}.by(1)
      end

      it 'redirects to the campaign show page' do
        valid_request
        expect(response).to redirect_to(campaign_path(Campaign.last))
      end

      it 'sets a notice' do
        valid_request
        expect(flash[:notice]).to be
      end
    end

    context 'with invalid campaign paramas' do
      def invalid_request
        post :create, {campaign: {title: "gg"}}
      end

      it 'sets an alert' do
        invalid_request
        expect(flash[:alert]).to be
      end

      it 'renders new template' do
        invalid_request
        expect(response).to render_template(:new)
      end

      it 'doesn\'t save to the db' do
        invalid_request
        expect{invalid_request}.to_not change{Campaign.count}
      end
    end
  end

end

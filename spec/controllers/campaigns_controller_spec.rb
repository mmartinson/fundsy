require 'rails_helper'

RSpec.describe CampaignsController, :type => :controller do
  let(:user) {create(:user)}
  let(:user1) {create(:user)}
  let(:campaign) {create(:campaign, user: user)}
  let(:campaign_1) {create(:campaign, user: user)}


  describe "#index" do

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

  describe "#new" do
    context 'with a signed in user' do
      before { login(user) }

      it "assigns a new campaign to a variable" do
        get :new
        expect(assigns(:campaign)).to be_a_new(Campaign)
      end

      it "renders a new template" do
        get :new
        expect(response).to render_template(:new)
      end
    end

    context 'without a signed in user' do

      it 'redirects to new session path' do
        get :new
        expect(response).to redirect_to new_session_path
      end
    end

  end

  describe "#create" do

    context 'without a signed in user' do
    end

    context 'with a signed in user' do
      before { login(user) }
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

        it 'assigns the logged in user to the campaign' do
          valid_request
          expect(Campaign.last.user).to eq(user)
        end

      end

      context 'with invalid campaign params' do
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

  describe "#show" do
    before { get :show, id: campaign.id }

    it "assigns an instance variable for campaign with passed id" do
      expect(assigns(:campaign)).to eq(campaign)
    end

    it "renders show template" do
      expect(response).to render_template(:show)
    end
  end

  describe "#edit" do

    context 'with owner signed in' do
      before do 
        login user
        get :edit, id: campaign.id 
      end

      it "renders an edit template" do
        expect(response).to render_template(:edit)
      end

      it "assigns an instance variable campaign with passed id" do
        expect(assigns(:campaign)).to eq(campaign)
      end
    end

    context 'with non-owner signed in' do
      before do 
        login user1
      end

      it 'raises error' do
        expect{ get :edit, id: campaign.id }.to raise_error
      end

    end
  end

  describe "#update" do
    before {login user}
    context "with valid params" do
      def valid_request(params = {title: campaign.title})
        patch :update, id: campaign, campaign: params
      end

      it "changes the title of campaign if it's different" do
        valid_request({title: "the hobbit"})
        campaign.reload
        expect(campaign.title).to eq("the hobbit")
      end
      it "changes the goal of campaign if it's different" do
        valid_request({goal: 100000000})
        expect(campaign.reload.goal).to eq(100000000)
      end
      it "redirect to the show page" do
        valid_request
        expect(response).to redirect_to(campaign_path(campaign))
      end
      it "sets a flash message" do
        valid_request
        expect(flash[:notice]).to be
      end
    end
    context "with invalid params" do
      def invalid_request(params = {title: ""})
        patch :update, id: campaign, campaign: params
      end
      it "doesn't change the record" do
        expect { invalid_request }.to_not change { campaign.reload.title }
      end
      it "renders the edit page" do
        invalid_request
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "#destroy" do
    context 'with owner signed in' do
      before {login user}
      let!(:campaign) { create(:campaign, user: user) }

      it "remove the campaign from the database" do
        expect { delete :destroy, id: campaign.id }.to change { Campaign.count }.by(-1)
      end

      it "redirect to campaign listing page" do
        delete :destroy, id: campaign.id
        expect(response).to redirect_to(campaigns_path)
      end
    end

    context 'with non-owner signed in' do
      before {login user}
      let!(:campaign) { create(:campaign, user: user1) }

      it 'should raise an error' do
        expect{delete :destroy, id: campaign.id}.to raise_error
      end

    end

  end
end
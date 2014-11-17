class CampaignsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_users_campaign, only: [ :edit, :update, :destroy]

  DEFAULT_REWARD_LEVEL_COUNT = 3

  def index
    @campaigns = Campaign.all
  end

  def new
    @campaign = Campaign.new
    DEFAULT_REWARD_LEVEL_COUNT.times { @campaign.reward_levels.build }
  end

  def create
    @campaign      = Campaign.new campaign_params
    @campaign.user = current_user
    if @campaign.save
      redirect_to campaign_path(@campaign), notice: "campaign created"
    else
      flash.now[:alert]   = cannot_save_flash
      reward_levels_count = DEFAULT_REWARD_LEVEL_COUNT - @campaign.reward_levels.length
      reward_levels_count.times {@campaign.reward_levels.build}
      render :new
    end
  end

  def show
    @campaign = Campaign.find params[:id]
  end

  def edit; end

  def update
    if @campaign.update_attributes campaign_params
      redirect_to campaign_path(@campaign), notice: "Campaign updated"
    else
      render :edit
    end
  end

  def destroy
    @campaign.destroy
    redirect_to campaigns_path, notice: 'Campaign deleted'
  end

  private

  def campaign_params
    params.require(:campaign).permit(:title,
     :description,
     :goal,
     :deadline,
     {reward_levels_attributes:
       [:id,
        :name,
        :price,
        :description,
        :limit,
        :_destroy]})
  end

  def find_users_campaign
    @campaign = current_user.campaigns.find params[:id]
  end

  def cannot_save_flash
   if @campaign.errors.messages.has_key? :reward_levels
    "Campaign must have at least one reward level"
  else
    'See error messages below'
  end
end
end

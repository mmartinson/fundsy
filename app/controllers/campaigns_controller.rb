class CampaignsController < ApplicationController
  def index
    @campaigns = Campaign.all
  end

  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new campaign_params
    if @campaign.save
      redirect_to campaign_path(@campaign), notice: "campaign created"
    else
      flash.now[:alert] = 'fail'
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def campaign_params
    params.require(:campaign).permit(:title, :description, :goal, :deadline)
  end
end

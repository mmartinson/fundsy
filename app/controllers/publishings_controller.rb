class PublishingsController < ApplicationController
  before_action :authenticate_user!

  def create
    @campaign  = Campaign.find params[:campaign_id]
    if @campaign.publish!
      redirect_to @campaign, notce: "Published"
    else
      redirect_to @campaign, alert:L "Not Pushlished"
    end
  end
end

class RewardLevel < ActiveRecord::Base
  belongs_to :campaign

  validates :name, :price, :description, presence: true
end

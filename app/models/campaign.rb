class Campaign < ActiveRecord::Base
  belongs_to :user
  has_many :reward_levels, dependent: :destroy
  accecpts_nested_attributes_for :reward_levels

  validates :title, :description, :deadline, :user_id,  presence: true
  validates :goal, numericality: {greater_than_or_equal_to: 10, allow_nil: true}
end

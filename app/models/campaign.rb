class Campaign < ActiveRecord::Base
  belongs_to :user
  has_many :reward_levels, dependent: :destroy
  accepts_nested_attributes_for :reward_levels,
    allow_destroy: true,
    reject_if: proc {|x| x[:price].blank? &&
                         x[:description].blank? &&
                         x[:name].blank?
                    }

  validates :title, :description, :deadline, :user_id,  presence: true
  validates :goal, numericality: {greater_than_or_equal_to: 10, allow_nil: true}
  validates :reward_levels, presence: true
end

class Campaign < ActiveRecord::Base
  belongs_to :user

  validates :title, :description, :deadline,  presence: true
  validates :goal, numericality: {greater_than_or_equal_to: 10, allow_nil: true}
end

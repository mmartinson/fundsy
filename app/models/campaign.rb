class Campaign < ActiveRecord::Base
  include AASM
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

  aasm whiny_transitions: false do 
    state :pending, inital: :true
    state :published
    state :cancelled 
    state :funded
    state :not_funded

    event :publish do
      transitions from: :pending, to: :published
    end

    event :cancel do
      transitions from: [:published, :pending], to: :cancelled
    end

    event :fund do
      transitions from: :published, to: :funded
    end

    event :fail do 
      transitions from: :published, to: :unfunded
    end
  end
end

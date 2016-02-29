class Vote < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates :user_id, uniqueness: {scope: :question_id}

  def self.up_count
    where(is_up: true).count
  end
  # Refactored
  # scope :up_count, -> { where(is_up: true).count }

  def self.down_count
    where(is_up: false).count
  end
  # Refactored
  # scope :down_count, -> { where(is_up: false).count }
end

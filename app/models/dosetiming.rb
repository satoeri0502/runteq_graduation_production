class Dosetiming < ApplicationRecord
  validates :dose_time, presence: true
  validates :dose_timing, presence: true
  # validates :reminder_time, presence: true

  belongs_to :medicine
end

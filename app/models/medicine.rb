class Medicine < ApplicationRecord
  validates :name, presence: true
  validates :dose_per_day, presence: true
  validates :pills_per_dose, presence: true
  validates :stock_count, presence: true

  belongs_to :user
  has_many :dosetimings, dependent: :destroy
end

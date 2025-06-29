class Medicine < ApplicationRecord
  validates :name, presence: true
  validates :dose_per_day, presence: true
  validates :pills_per_dose, presence: true
  validates :stock_count, presence: true

  belongs_to :user
  has_many :dosetimings, dependent: :destroy

  # ネスト属性を許可。_destroy で削除も可能に。
  accepts_nested_attributes_for :dosetimings,
                                allow_destroy: true,
                                reject_if: ->(attrs) { attrs["dose_time"].blank? }
end

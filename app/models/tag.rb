class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tickets, through: :taggings
  scope :most_used, -> { order(taggings_count: :desc).first }
end

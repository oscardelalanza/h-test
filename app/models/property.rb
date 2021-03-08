class Property < ApplicationRecord
  belongs_to :owner

  validates :name, presence: true, length: { maximum: 45 }
  validates :description, presence: true, length: { maximum: 255 }
  validates :status, presence: true, inclusion: { in: %w[published available deleted] }
  validates :rental_price, presence: true, numericality: true, length: { maximum: 11 }, exclusion: { in: [nil] }
  scope :published, -> { where(status: 'published') }
end

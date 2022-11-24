class Flight < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  validates :capacity, :departure, :arrival, :date, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  geocoded_by :arrival
  after_validation :geocode, if: :will_save_change_to_arrival?
end

class Flight < ApplicationRecord
  belongs_to :user
  has_many :bookings
  validates :capacity, :departure, :arrival, :date, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
end

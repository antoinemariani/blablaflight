class Flight < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :bookings, dependent: :destroy
  validates :capacity, :departure, :arrival, :date, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
end

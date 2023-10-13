class Listing < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_many :bookings, dependent: :destroy
  has_many :reviews, foreign_key: :user_id, as: :reviewable

  def average_raintg
    reviews.average(:rating).to_f
  end
end
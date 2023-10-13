class Booking < ApplicationRecord
  has_many :reviews, as: :reviewable
  belongs_to :user
  belongs_to :listing, foreign_key: :user_id, required: true

  before_validation :set_default_listing, on: :after_create

  after_create :calculate_duration_and_total_price

  private
  def set_default_listing
    self.listing ||= Listing.find_by(default: true)
  end

  def calculate_duration_and_total_price
    duration = (check_out.to_date - check_in.to_date).to_i
    total_price = duration * listing.price
    update(duration: duration, total_price: total_price)
  end
end
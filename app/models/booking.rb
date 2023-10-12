class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :listing, foreign_key: :user_id
  after_create :calculate_duration_and_total_price

  private

  def calculate_duration_and_total_price
    duration = (check_out.to_date - check_in.to_date).to_i
    total_price = duration * listing.price
    update(duration: duration, total_price: total_price)
  end
end
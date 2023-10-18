class BookingsController < ApplicationController

  def index
    @bookings = Booking.all
  end

  def new
    @listing = Listing.find_by(id: params[:listing_id])
    @booking = Booking.new
  end

  def create
    # binding.break
    @listing = Listing.find_by(id: params[:booking][:listing_id])
    puts "Listing ID: #{@listing&.id}"

    @booking = current_user.bookings.new(booking_params)
    puts "Booking Check-in: #{@booking&.check_in}"
    puts "Booking Check-out: #{@booking&.check_out}"
    
    @booking.listing_id = @listing.id

    if available_dates?(@booking.check_in, @booking.check_out, @listing)
      if @booking.save
        redirect_to booking_path(@booking), notice: "Booking created"
      else
        render :new
      end
    else
      redirect_to listings_path(@listing), notice: "Booking failed"
    end
  end

  private
    def booking_params
      params.require(:booking).permit(:listing_id, :check_in, :check_out)
    end

    def available_dates?(ci_date, co_date, listing)
      if listing.present?
        overlap_bookings = listing.bookings.where(check_in: ci_date..co_date)
          .or(listing.bookings.where(check_out: ci_date..co_date))
        overlap_bookings.blank?
      else
        false
      end
    end
    
end
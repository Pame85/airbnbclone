class ReviewsController < ApplicationController

  def create
    @listing = Listing.find(params[:listing_id])
    @reviews = @listing.review.new(review_params)
    @review.user = current_user
    if @review.save
      redirect_to @listing, notice: 'Review was successfully created.'
    else
      # Handle validation errors and render the appropriate view
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @listing = @review.listing
    @review.destroy
    redirect_to @listing, notice: 'Review was successfully destroyed.'
  end
end
class ReviewsController < ApplicationController

  def new
    @listing = Listing.find(params[:listing_id])
    @review = Review.new
  end

  def create
    # binding.break
    @review = Review.new(review_params)
    @review.listing_id = params[:listing_id]
    @review.user = current_user
    if @review.save
      redirect_to @listing, notice: 'Review was successfully created.'
    else
      puts @review.errors.full_messages
      render :new
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @listing = @review.listing
    @review.destroy
    redirect_to @listing, notice: 'Review was successfully destroyed.'
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
end
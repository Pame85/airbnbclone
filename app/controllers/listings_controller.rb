class ListingsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @listings = Listing.all

    if params[:availability].present?
      @listings = @listings.where(availability: params[:availability])
    end

    if params[:location].present?
      @listings = @listings.where("location ILIKE ?", "%#{params[:location]}%")
    end

    if params[:check_in].present? && params[:check_out].present?
      check_in_date = Date.parse(params[:check_in])
      check_out_date = Date.parse(params[:check_out])
      @listings = @listings.joins(:bookings).where.not("bookings.check_out < ? OR bookings.check_in > ?", check_in_date, check_out_date)
    end
  end

  def show
    @listing = Listing.find(params[:id])
    @reviews = @listing.reviews
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = current_user.listings.new(listing_params)
    # binding.break
    if @listing.save
      redirect_to listings_path, notice: 'Listing was successfully created.'
    else
      render :new
    end
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:id])
    if @listing.update(listing_params)
      redirect_to @listing, notice: 'Listing was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    redirect_to listings_url, notice: 'Listing was successfully destroyed.'
  end

  private

  def listing_params
    params.require(:listing).permit(:title, :description, :price, :location)
  end
end
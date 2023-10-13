class HomeController < ApplicationController

    def index
        @listings = Listing.all

        if params[:filter_by_location].present?
            @listings = @listings.where(location: params[:filter_by_location])
        end

        if params[:filter_by_check_in].present? && params[:filter_by_check_out].present?
            check_in_date = Date.parse(params[:filter_by_check_in])
            check_out_date = Date.parse(params[:filter_by_check_out])
            @listings = @listings.where("check_in_date <= ? AND check_out_date >= ?", check_in_date, check_out_date)
        end

        render :index
    end

end
class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    start_of_search_date = params["date"].to_datetime
    end_of_search_date = params["date"].to_datetime.end_of_day

    render json: TotalRevenueSerializer.new(
      Merchant.total_revenue_for_day(params["date"]))
  end
end

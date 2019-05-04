class Api::V1::Merchants::RevenueForDateController < ApplicationController
  def show
    render json: TotalRevenueSerializer.new(
      Merchant.total_revenue_for_day(params["date"])
    )
  end
end

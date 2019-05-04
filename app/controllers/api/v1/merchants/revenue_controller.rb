class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    render json: RevenueSerializer.new(
      Merchant.merchant_revenue_for_day(params[:id], params[:date])
    )
  end
end

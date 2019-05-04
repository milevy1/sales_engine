class Api::V1::Merchants::SearchController < ApplicationController
  def index
    render json: MerchantSerializer.new(
      Merchant.where(attribute_name => attribute_value)
    )
  end

  def show
    render json: MerchantSerializer.new(
      Merchant.find_by(attribute_name => attribute_value)
    )
  end
end

class Api::V1::Merchants::SearchController < ApplicationController
  def index

  end

  def show
    attribute_name = params.keys.first
    attribute_value = params.values.first

    render json: MerchantSerializer.new(Merchant.find_by(attribute_name => attribute_value))
  end
end

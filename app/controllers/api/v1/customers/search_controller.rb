class Api::V1::Customers::SearchController < ApplicationController
  def index
    render json: CustomerSerializer.new(
      Customer.where(attribute_name => attribute_value)
    )
  end

  def show
    render json: CustomerSerializer.new(
      Customer.find_by(attribute_name => attribute_value)
    )
  end
end

class Api::V1::Customers::SearchController < ApplicationController
  def index
    attribute_name = params.keys.first
    attribute_value = params.values.first

    render json: CustomerSerializer.new(
      Customer.where(attribute_name => attribute_value))
  end

  def show
    attribute_name = params.keys.first
    attribute_value = params.values.first

    render json: CustomerSerializer.new(
      Customer.find_by(attribute_name => attribute_value))
  end
end

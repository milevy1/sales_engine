class Api::V1::Items::SearchController < ApplicationController
  def index
    attribute_name = params.keys.first
    attribute_value = params.values.first

    if attribute_name == "unit_price"
      attribute_value = (BigDecimal(attribute_value) * 100).to_i
    end

    render json: ItemSerializer.new(
      Item.where(attribute_name => attribute_value).order(:id))
  end

  def show
    attribute_name = params.keys.first
    attribute_value = params.values.first

    if attribute_name == "unit_price"
      attribute_value = (BigDecimal(attribute_value) * 100).to_i
    end

    render json: ItemSerializer.new(
      Item.order(:id).find_by(attribute_name => attribute_value))
  end
end

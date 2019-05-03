class Api::V1::InvoiceItems::SearchController < ApplicationController
  def index
    attribute_name = params.keys.first
    attribute_value = params.values.first

    if attribute_name == "unit_price"
      attribute_value = (BigDecimal(attribute_value) * 100).to_i
    end

    render json: InvoiceItemSerializer.new(
      InvoiceItem.where(attribute_name => attribute_value).order(:id))
  end

  def show
    attribute_name = params.keys.first
    attribute_value = params.values.first

    if attribute_name == "unit_price"
      attribute_value = (BigDecimal(attribute_value) * 100).to_i
    end

    render json: InvoiceItemSerializer.new(
      InvoiceItem.order(:id).find_by(attribute_name => attribute_value))
  end
end

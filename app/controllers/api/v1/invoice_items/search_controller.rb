class Api::V1::InvoiceItems::SearchController < ApplicationController
  def index
    render json: InvoiceItemSerializer.new(
      InvoiceItem.where(attribute_name => attribute_value).order(:id)
    )
  end

  def show
    render json: InvoiceItemSerializer.new(
      InvoiceItem.find_by(attribute_name => attribute_value)
    )
  end
end

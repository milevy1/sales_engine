class Api::V1::Invoices::SearchController < ApplicationController
  def index
    attribute_name = params.keys.first
    attribute_value = params.values.first

    render json: InvoiceSerializer.new(
      Invoice.where(attribute_name => attribute_value).order(:id))
  end

  def show
    attribute_name = params.keys.first
    attribute_value = params.values.first

    render json: InvoiceSerializer.new(
      Invoice.find_by(attribute_name => attribute_value))
  end
end

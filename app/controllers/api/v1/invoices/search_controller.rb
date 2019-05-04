class Api::V1::Invoices::SearchController < ApplicationController
  def index
    render json: InvoiceSerializer.new(
      Invoice.where(attribute_name => attribute_value).order(:id)
    )
  end

  def show
    render json: InvoiceSerializer.new(
      Invoice.find_by(attribute_name => attribute_value)
    )
  end
end

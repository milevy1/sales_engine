class Api::V1::Invoices::InvoiceItemsController < ApplicationController
  def index
    render json: InvoiceItemSerializer.new(
      InvoiceItem.joins(:invoice).where("invoices.id = ?", params[:id])
    )
  end
end

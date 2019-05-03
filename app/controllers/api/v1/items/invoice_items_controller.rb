class Api::V1::Items::InvoiceItemsController < ApplicationController
  def index
    render json: InvoiceItemSerializer.new(
      InvoiceItem.joins(:item).where("items.id = ?", params[:id]))
  end
end

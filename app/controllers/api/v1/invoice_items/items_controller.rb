class Api::V1::InvoiceItems::ItemsController < ApplicationController
  def show
    render json: ItemSerializer.new(
      Item.joins(:invoice_items).where("invoice_items.id = ?", params[:id])[0]
    )
  end
end

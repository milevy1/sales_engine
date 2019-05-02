class Api::V1::Items::MostItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(
      Item.joins(invoice_items: {invoice: :transactions}).select("items.*, SUM(invoice_items.quantity) as items_sold").where("transactions.result = 'success'").group(:id).order("items_sold DESC").limit(params[:quantity])
    )
  end
end

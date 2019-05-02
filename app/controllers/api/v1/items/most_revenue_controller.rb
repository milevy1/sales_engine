class Api::V1::Items::MostRevenueController < ApplicationController
  def index
    render json: ItemSerializer.new(
      Item.joins(invoice_items: {invoice: :transactions}).select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) as revenue").where("transactions.result = 'success'").group(:id).order("revenue DESC").limit(params[:quantity]))
  end
end

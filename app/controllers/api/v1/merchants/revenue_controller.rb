class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    render json: RevenueSerializer.new(
      Merchant.joins(invoices: [:invoice_items, :transactions]).where("transactions.result = ? AND merchants.id = ?", "success", params[:id]).select("SUM(invoice_items.quantity * invoice_items.unit_price) as revenue")[0]
    )
  end
end

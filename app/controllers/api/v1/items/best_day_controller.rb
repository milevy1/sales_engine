class Api::V1::Items::BestDayController < ApplicationController
  def show
    render json: BestDaySerializer.new(
      Invoice.joins({invoice_items: :item}, :transactions).select("invoices.created_at as order_date, SUM(invoice_items.quantity) as item_count").where("transactions.result = ? AND items.id = ?", "success", params[:id]).order("item_count DESC, order_date DESC").group("order_date").limit(1)[0]
    )
  end
end

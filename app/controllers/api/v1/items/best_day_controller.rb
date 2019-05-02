class Api::V1::Items::BestDayController < ApplicationController
  def show
    render json: BestDaySerializer.new(
      Invoice.joins({invoice_items: :item}, :transactions).select("invoices.created_at as order_date").where("transactions.result = ? AND items.id = ?", "success", params[:id]).order("SUM(invoice_items.quantity) DESC, order_date DESC").group("order_date").limit(1)[0]
    )
  end
end

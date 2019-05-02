class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    if params[:date]
      start_of_search_date = params[:date].to_datetime
      end_of_search_date = start_of_search_date.end_of_day

      render json: RevenueSerializer.new(
        Merchant.joins(invoices: [:invoice_items, :transactions]).where("transactions.result = ? AND merchants.id = ? AND invoices.created_at BETWEEN ? AND ?", "success", params[:id], start_of_search_date, end_of_search_date).select("SUM(invoice_items.quantity * invoice_items.unit_price) as revenue")[0]
      )
    else
    render json: RevenueSerializer.new(
      Merchant.joins(invoices: [:invoice_items, :transactions]).where("transactions.result = ? AND merchants.id = ?", "success", params[:id]).select("SUM(invoice_items.quantity * invoice_items.unit_price) as revenue")[0]
    )
    end
  end
end

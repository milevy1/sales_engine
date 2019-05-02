class Api::V1::Merchants::FavoriteCustomerController < ApplicationController
  def show
    render json: CustomerSerializer.new(
      Customer.joins(invoices: [:merchant, :transactions]).select("customers.*, COUNT(transactions.id) as transaction_count").group(:id).order("transaction_count DESC").limit(10).where("transactions.result = ? AND merchants.id = ?", "success", params[:id])[0]
    )
  end
end

class Api::V1::Customers::FavoriteMerchantController < ApplicationController
  def show
    render json: MerchantSerializer.new(
      Merchant.select("merchants.*, COUNT(transactions.result) as transaction_count").joins(invoices: [:transactions, :customer]).where("transactions.result = ? AND customers.id = ?", 'success', params[:id]).order("transaction_count DESC").group(:id).limit(1)[0]
    )
  end
end

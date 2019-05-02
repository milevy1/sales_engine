class Api::V1::Customers::FavoriteMerchantController < ApplicationController
  def show
    render json: MerchantSerializer.new(
      Merchant.joins(invoices: [:transactions, :customer]).where("transactions.result = ? AND customers.id = ?", 'success', params[:id]).order("COUNT(transactions.result) DESC").group(:id).limit(1)[0]
    )
  end
end

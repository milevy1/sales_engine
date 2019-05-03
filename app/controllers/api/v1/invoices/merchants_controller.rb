class Api::V1::Invoices::MerchantsController < ApplicationController
  def show
    render json: MerchantSerializer.new(
      Merchant.joins(:invoices).where("invoices.id = ?", params[:id])[0]
    )
  end
end

class Api::V1::Transactions::InvoicesController < ApplicationController
  def show
    render json: InvoiceSerializer.new(
      Invoice.joins(:transactions).where("transactions.id = ?", params[:id])[0])
  end
end

class Api::V1::Invoices::TransactionsController < ApplicationController
  def index
    render json: TransactionSerializer.new(
      Transaction.joins(:invoice).where("invoices.id = ?", params[:id])
    )
  end
end

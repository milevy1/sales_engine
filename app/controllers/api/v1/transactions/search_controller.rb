class Api::V1::Transactions::SearchController < ApplicationController
  def index
    render json: TransactionSerializer.new(
      Transaction.where(attribute_name => attribute_value).order(:id)
    )
  end

  def show
    render json: TransactionSerializer.new(
      Transaction.order(:id).find_by(attribute_name => attribute_value)
    )
  end
end

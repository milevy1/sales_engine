class Api::V1::Transactions::SearchController < ApplicationController
  def index
    attribute_name = params.keys.first
    attribute_value = params.values.first

    render json: TransactionSerializer.new(
      Transaction.where(attribute_name => attribute_value))
  end

  def show
    attribute_name = params.keys.first
    attribute_value = params.values.first

    render json: TransactionSerializer.new(
      Transaction.order(:id).find_by(attribute_name => attribute_value))
  end
end

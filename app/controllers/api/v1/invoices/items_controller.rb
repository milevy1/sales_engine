class Api::V1::Invoices::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(
      Item.joins(:invoices).where("invoices.id = ?", params[:id])
    )
  end
end

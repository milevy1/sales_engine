class Api::V1::Items::SearchController < ApplicationController
  def index
    render json: ItemSerializer.new(
      Item.where(attribute_name => attribute_value).order(:id)
    )
  end

  def show
    render json: ItemSerializer.new(
      Item.order(:id).find_by(attribute_name => attribute_value)
    )
  end
end

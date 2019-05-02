class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :merchant_id

  attribute :unit_price do |object|
    "#{BigDecimal(object.unit_price) / 100}"
  end
end

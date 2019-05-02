class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :item_id, :invoice_id, :quantity

  attribute :unit_price do |object|
    "#{BigDecimal(object.unit_price) / 100}"
  end
end

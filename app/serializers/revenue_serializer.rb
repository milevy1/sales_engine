class RevenueSerializer
  include FastJsonapi::ObjectSerializer

  attribute :revenue do |object|
    "#{BigDecimal(object.revenue) / 100}"
  end
end

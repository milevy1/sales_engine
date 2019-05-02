class RevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :revenue

  attribute :revenue do |object|
    "#{BigDecimal(object.revenue) / 100}"
  end
end

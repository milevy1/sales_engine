class TotalRevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :total_revenue

  attribute :total_revenue do |object|
    "#{BigDecimal(object.total_revenue) / 100}"
  end
end

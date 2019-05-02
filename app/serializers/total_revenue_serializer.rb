class TotalRevenueSerializer
  include FastJsonapi::ObjectSerializer

  attribute :total_revenue do |object|
    "#{BigDecimal(object.total_revenue) / 100}"
  end
end

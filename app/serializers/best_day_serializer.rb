class BestDaySerializer
  include FastJsonapi::ObjectSerializer
  attribute :best_day do |object|
    object.order_date.strftime("%Y-%m-%d")
  end
end

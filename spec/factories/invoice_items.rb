FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    sequence(:quantity) { |n| (n + 1) * 3 }
    sequence(:unit_price) { |n| (n + 1) * 5 }
  end
end

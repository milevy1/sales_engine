class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name, :description
  validates :unit_price,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than: 0
    }

  def unit_price_to_dollar_string
    (self.unit_price.to_f / 100).to_s
  end

  def self.best_day(item_id)
    Invoice.joins({invoice_items: :item}, :transactions)
    .select("invoices.created_at as order_date, SUM(invoice_items.quantity) as item_count")
    .where("transactions.result = ? AND items.id = ?", "success", item_id)
    .order("item_count DESC, order_date DESC")
    .group("order_date")
    .limit(1)[0]
  end
end

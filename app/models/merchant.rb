class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  validates_presence_of :name

  def self.most_revenue(quantity)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .joins(items: :invoice_items)
    .group(:id)
    .order("revenue DESC")
    .limit(quantity)
    # .joins(invoices: :transactions)
    # .where("transactions.result = ?", "success")
  end
end

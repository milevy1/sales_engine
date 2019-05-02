class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  validates_presence_of :name

  def self.most_revenue(limit)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(items: :invoice_items)
    .group(:id)
    .order("revenue DESC")
    .limit(limit)
  end

  def self.top_by_items_sold(limit)
    select("merchants.*, SUM(invoice_items.quantity) AS quantity_sold")
    .joins(invoices: [:invoice_items, :transactions])
    .where("transactions.result = ?", "success")
    .group(:id)
    .order("quantity_sold DESC")
    .limit(limit)
  end

  def self.total_revenue_for_day(date)
    start_of_search_date = date.to_datetime
    end_of_search_date = date.to_datetime.end_of_day

    InvoiceItem.joins(invoice: :transactions)
    .where("transactions.result = ? AND invoices.created_at BETWEEN ? AND ?", 'success', start_of_search_date, end_of_search_date)
    .select("SUM(invoice_items.quantity * invoice_items.unit_price) as total_revenue")[0]
  end
end

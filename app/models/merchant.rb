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
    end_of_search_date = start_of_search_date.end_of_day

    InvoiceItem.joins(invoice: :transactions)
    .where("transactions.result = ? AND invoices.created_at BETWEEN ? AND ?", 'success', start_of_search_date, end_of_search_date)
    .select("SUM(invoice_items.quantity * invoice_items.unit_price) as total_revenue")[0]
  end

  def self.favorite_customer(merchant_id)
    Customer.joins(invoices: [:merchant, :transactions])
    .select("customers.*, COUNT(transactions.id) as transaction_count")
    .where("transactions.result = ? AND merchants.id = ?", "success", merchant_id)
    .group(:id)
    .order("transaction_count DESC")
    .limit(1)[0]
  end

  def self.merchant_revenue_for_day(merchant_id, search_date = nil)
    if search_date.nil?
      Merchant.joins(invoices: [:invoice_items, :transactions])
      .where("transactions.result = ? AND merchants.id = ?", "success", merchant_id)
      .select("SUM(invoice_items.quantity * invoice_items.unit_price) as revenue")[0]
    else
      start_of_search_date = search_date.to_datetime
      end_of_search_date = start_of_search_date.end_of_day

      Merchant.joins(invoices: [:invoice_items, :transactions])
      .where("transactions.result = ? AND merchants.id = ?", "success", merchant_id)
      .where("invoices.created_at BETWEEN ? AND ?", start_of_search_date, end_of_search_date)
      .select("SUM(invoice_items.quantity * invoice_items.unit_price) as revenue")[0]
    end
  end

  def self.customers_with_pending_invoices(merchant_id)
    Customer.find_by_sql([
      "SELECT c.*, i.id AS invoice_id FROM customers c
        INNER JOIN invoices i ON i.customer_id = c.id
        LEFT OUTER JOIN transactions t ON t.invoice_id = i.id
        WHERE i.merchant_id = ? AND (t.result = ? OR t.result IS null)
      EXCEPT
      SELECT c.*, i.id AS invoice_id FROM customers c
        INNER JOIN invoices i ON i.customer_id = c.id
        INNER JOIN transactions t ON t.invoice_id = i.id
        WHERE i.merchant_id = ? AND t.result = ?",
        merchant_id, 'failed', merchant_id, 'success'])
  end
end

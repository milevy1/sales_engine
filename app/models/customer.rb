class Customer < ApplicationRecord
  has_many :invoices

  validates_presence_of :first_name, :last_name

  def self.favorite_merchant(customer_id)
    Merchant.select("merchants.*, COUNT(transactions.result) as transaction_count")
    .joins(invoices: [:transactions, :customer])
    .where("transactions.result = ? AND customers.id = ?", 'success', customer_id)
    .order("transaction_count DESC")
    .group(:id)
    .limit(1)[0]
  end
end

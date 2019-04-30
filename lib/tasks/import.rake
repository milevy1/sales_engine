# To run from terminal: rails import:prospect
require 'csv'

namespace :import do
  desc "Import data from CSV files to database"
  task prospect: :environment do
    Merchant.destroy_all
    CSV.foreach('./data/merchants.csv', headers: true) do |row|
      Merchant.create!(row.to_h)
    end

    Customer.destroy_all
    CSV.foreach('./data/customers.csv', headers: true) do |row|
      Customer.create!(row.to_h)
    end

    Item.destroy_all
    CSV.foreach('./data/items.csv', headers: true) do |row|
      Item.create!(row.to_h)
    end

    Invoice.destroy_all
    CSV.foreach('./data/invoices.csv', headers: true) do |row|
      Invoice.create!(row.to_h)
    end

    InvoiceItem.destroy_all
    CSV.foreach('./data/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create!(row.to_h)
    end

    Transaction.destroy_all
    CSV.foreach('./data/transactions.csv', headers: true) do |row|
      Transaction.create!(row.to_h)
    end
  end
end

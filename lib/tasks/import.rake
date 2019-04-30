# To run from terminal: rails import:prospect
require 'csv'

namespace :import do
  desc "Import data from CSV files to database"
  task prospect: :environment do
    Merchant.destroy_all

    CSV.foreach('./data/merchants.csv', headers: true) do |row|
      Merchant.create(row.to_h)
    end
  end
end

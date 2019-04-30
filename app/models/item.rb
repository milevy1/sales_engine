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
end

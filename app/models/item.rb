class Item < ApplicationRecord
  belongs_to :merchant

  validates_presence_of :name, :description
  validates :unit_price,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than: 0
    }
end

class Transaction < ApplicationRecord
  belongs_to :invoice

  validates_presence_of :result
  validates :credit_card_number,
    presence: true,
    numericality: { only_integer: true }
end

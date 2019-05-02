require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name}
  end

  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :invoices }
  end

  describe 'Class methods' do
    describe '.most_revenue' do
      it 'returns the top x merchants ranked by total revenue' do
        @merchants = create_list(:merchant, 3)

        @item_1 = create(:item, merchant: @merchants[0])
        @item_2 = create(:item, merchant: @merchants[1])
        @item_3 = create(:item, merchant: @merchants[2])

        @invoice_1 = create(:invoice, merchant: @merchants[0])
        @invoice_2 = create(:invoice, merchant: @merchants[1])
        @invoice_3 = create(:invoice, merchant: @merchants[2])

        @invoice_item_1 = create(:invoice_item,
          item: @item_1,
          invoice: @invoice_1,
          quantity: 2,
          unit_price: 5)

        @invoice_item_2 = create(:invoice_item,
          item: @item_2,
          invoice: @invoice_2,
          quantity: 2,
          unit_price: 4)

        @invoice_item_3 = create(:invoice_item,
          item: @item_3,
          invoice: @invoice_3,
          quantity: 2,
          unit_price: 1)

        expect(Merchant.most_revenue(2)).to eq([@merchants[0], @merchants[1]])
      end
    end
  end
end

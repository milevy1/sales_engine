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
    before :each do
      @merchants = create_list(:merchant, 3)

      @item_1 = create(:item, merchant: @merchants[0])
      @item_2 = create(:item, merchant: @merchants[1])
      @item_3 = create(:item, merchant: @merchants[2])

      @search_date = "2012-03-16"
      @invoice_1 = create(:invoice, merchant: @merchants[0], created_at: @search_date)
      @invoice_2 = create(:invoice, merchant: @merchants[1], created_at: @search_date)
      @invoice_3 = create(:invoice, merchant: @merchants[2])

      @transaction_1 = create(:transaction, invoice: @invoice_1)
      @transaction_2 = create(:transaction, invoice: @invoice_2)
      @transaction_3 = create(:failed_transaction, invoice: @invoice_3)

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
    end

    describe '.most_revenue' do
      it 'returns the top x merchants ranked by total revenue' do
        expect(Merchant.most_revenue(2)).to eq([@merchants[0], @merchants[1]])
      end
    end

    describe '.total_revenue_for_day' do
      it 'returns the total revenue for date x across all merchants' do
        expected_revenue = @invoice_item_1.quantity * @invoice_item_1.unit_price + @invoice_item_2.quantity * @invoice_item_2.unit_price

        expect(Merchant.total_revenue_for_day(@search_date).total_revenue).to eq(expected_revenue)
      end
    end
  end
end

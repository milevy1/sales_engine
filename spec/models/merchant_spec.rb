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
      @favorite_customer = create(:customer)

      @unpaid_customer_1 = create(:customer) # Only a failed transaction
      @unpaid_customer_2 = create(:customer) # No transactions

      @item_1 = create(:item, merchant: @merchants[0])
      @item_2 = create(:item, merchant: @merchants[1])
      @item_3 = create(:item, merchant: @merchants[2])

      @search_date = "2012-03-16"
      @invoice_1 = create(:invoice, merchant: @merchants[0], customer: @favorite_customer, created_at: @search_date)
      @invoice_2 = create(:invoice, merchant: @merchants[1], created_at: @search_date)
      @invoice_3 = create(:invoice, merchant: @merchants[2], customer: @unpaid_customer_1)
      @invoice_4 = create(:invoice, merchant: @merchants[2], customer: @unpaid_customer_2)
      @paid_invoice = create(:invoice, merchant: @merchants[2])

      @transaction_1 = create(:transaction, invoice: @invoice_1)
      @transaction_2 = create(:transaction, invoice: @invoice_2)
      @transaction_3 = create(:failed_transaction, invoice: @invoice_3)
      @paid_transaction = create(:transaction, invoice: @paid_invoice)

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

    describe '.favorite_customer' do
      it 'returns the customer who has conducted the most total number of successful transactions' do
        expect(Merchant.favorite_customer(@merchants[0].id)).to eq(@favorite_customer)
      end
    end

    describe '.merchant_revenue_for_day' do
      it 'returns one merchant total revenue for a given day' do
        expected = Merchant.merchant_revenue_for_day(@merchants[0].id, @search_date)

        expect(expected.revenue).to eq(10)
      end

      it 'returns all revenue if no search date argument given' do
        expected = Merchant.merchant_revenue_for_day(@merchants[0].id)

        expect(expected.revenue).to eq(10)
      end
    end

    describe '.customers_with_pending_invoices' do
      it 'returns a collection of customers which have pending (unpaid) invoices' do
        merchant_id = @merchants[2].id
        expected = [@unpaid_customer_1, @unpaid_customer_2]

        expect(Merchant.customers_with_pending_invoices(merchant_id).size).to eq(2)
        expect(Merchant.customers_with_pending_invoices(merchant_id)[0]).to be_in(expected)
        expect(Merchant.customers_with_pending_invoices(merchant_id)[1]).to be_in(expected)
      end
    end
  end
end

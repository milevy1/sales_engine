require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many :invoices }
  end

  describe 'validations' do
    it { should validate_presence_of :first_name}
    it { should validate_presence_of :last_name}
  end

  describe 'Class methods' do
    before :each do
      @customer = create(:customer)
      @merchants = create_list(:merchant, 3)

      @item_1 = create(:item, merchant: @merchants[0])
      @item_2 = create(:item, merchant: @merchants[1])
      @item_3 = create(:item, merchant: @merchants[2])

      @invoice_1a = create(:invoice, merchant: @merchants[0], customer: @customer)
      @invoice_1b = create(:invoice, merchant: @merchants[0], customer: @customer)
      @invoice_2 = create(:invoice, merchant: @merchants[1])
      @invoice_3 = create(:invoice, merchant: @merchants[2])

      @transaction_1a = create(:transaction, invoice: @invoice_1a)
      @transaction_1b = create(:transaction, invoice: @invoice_1b)
      @transaction_2 = create(:transaction, invoice: @invoice_2)
      @transaction_3 = create(:failed_transaction, invoice: @invoice_3)

      @invoice_item_1a = create(:invoice_item,
        item: @item_1,
        invoice: @invoice_1a,
        quantity: 2,
        unit_price: 5)

      @invoice_item_1b = create(:invoice_item,
        item: @item_1,
        invoice: @invoice_1b,
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

    describe '.favorite_merchants(customer_id)' do
      it 'returns a merchant where the customer has conducted the most successful transactions' do
        expect(Customer.favorite_merchant(@customer.id)).to eq(@merchants[0])
      end
    end
  end
end

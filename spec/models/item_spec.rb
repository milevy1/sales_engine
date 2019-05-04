require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_numericality_of(:unit_price).only_integer }
    it { should validate_numericality_of(:unit_price).is_greater_than(0) }
  end

  describe 'Class Methods' do
    before :each do
      @merchant = create(:merchant)
      @item_1 = create(:item, merchant: @merchant)
      @other_items = create_list(:item, 2)

      @search_date = "2012-03-16"
      @invoice_1 = create(:invoice, merchant: @merchant, created_at: @search_date)
      @invoice_2 = create(:invoice, merchant: @merchant, created_at: @search_date)
      @invoice_3 = create(:invoice, merchant: @merchant)

      @transaction_1 = create(:transaction, invoice: @invoice_1)
      @transaction_2 = create(:transaction, invoice: @invoice_2)
      @transaction_3 = create(:transaction, invoice: @invoice_3)

      @invoice_item_1 = create(:invoice_item,
        item: @item_1,
        invoice: @invoice_1,
        quantity: 1,
        unit_price: 5)

      @invoice_item_2 = create(:invoice_item,
        item: @item_1,
        invoice: @invoice_2,
        quantity: 1,
        unit_price: 5)

      @invoice_item_3 = create(:invoice_item,
        item: @item_1,
        invoice: @invoice_3,
        quantity: 1,
        unit_price: 5)
    end

    describe '.best_day' do
      it 'returns a AR relation grouped by invoices.created_at as order_date ordered by sum of quantity of items sold' do
        expect(Item.best_day(@item_1.id).order_date).to eq(@search_date)
      end
    end

    describe '.most_items_sold' do
      it 'returns the top x item instances ranked by total number sold' do
        expect(Item.most_items_sold(1)).to eq([@item_1])
      end
    end

    describe '.most_revenue' do
      it 'returns the top x items ranked by total revenue generated' do
        expect(Item.most_revenue(1)).to eq([@item_1])
      end
    end
  end
end

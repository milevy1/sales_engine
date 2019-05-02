require 'rails_helper'

describe 'Items API Business Intelligence Endpoints' do
  before :each do
    @merchants = create_list(:merchant, 3)
    @favorite_customer = create(:customer)

    @item_1 = create(:item, merchant: @merchants[0])
    @item_2 = create(:item, merchant: @merchants[1])
    @item_3 = create(:item, merchant: @merchants[2])

    @search_date = "2012-03-16"
    @invoice_1 = create(:invoice, merchant: @merchants[0], created_at: @search_date, customer: @favorite_customer)
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

  describe 'GET /api/v1/items/most_revenue?quantity=x' do
    it "returns the top x items ranked by total revenue generated" do
      quantity = 2

      get "/api/v1/items/most_revenue?quantity=#{quantity}"
      expect(response).to be_successful

      top_2_items = JSON.parse(response.body)["data"]

      expect(top_2_items.count).to eq(quantity)
      expect(top_2_items[0]["id"].to_i).to eq(@item_1.id)
      expect(top_2_items[1]["id"].to_i).to eq(@item_2.id)
    end
  end


end

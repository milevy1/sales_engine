require 'rails_helper'

describe 'Merchants API Business Intelligence Endpoints' do
  before :each do
    @merchants = create_list(:merchant, 3)

    @item_1 = create(:item, merchant: @merchants[0])
    @item_2 = create(:item, merchant: @merchants[1])
    @item_3 = create(:item, merchant: @merchants[2])

    @invoice_1 = create(:invoice, merchant: @merchants[0])
    @invoice_2 = create(:invoice, merchant: @merchants[1])
    @invoice_3 = create(:invoice, merchant: @merchants[2])

    @transaction_1 = create(:transaction, invoice: @invoice_1)
    @transaction_2 = create(:transaction, invoice: @invoice_2)
    @transaction_3 = create(:transaction, invoice: @invoice_3)

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

  it "can get the top x merchants ranked by total revenue" do
    quantity = 2

    get "/api/v1/merchants/most_revenue?quantity=#{quantity}"
    expect(response).to be_successful

    top_2_merchants = JSON.parse(response.body)["data"]

    expect(top_2_merchants.count).to eq(quantity)
    expect(top_2_merchants[0]["id"].to_i).to eq(@merchants[0].id)
    expect(top_2_merchants[1]["id"].to_i).to eq(@merchants[1].id)
  end

  it 'GET /api/v1/merchants/most_items?quantity=x returns the top x merchants ranked by total number of items sold' do
    quantity = 2

    get "/api/v1/merchants/most_items?quantity=#{quantity}"
    expect(response).to be_successful
  end
end

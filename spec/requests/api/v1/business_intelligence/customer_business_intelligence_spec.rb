require 'rails_helper'

describe 'Customers API Business Intelligence Endpoints' do
  before :each do
    @merchants = create_list(:merchant, 3)
    @customer = create(:customer)

    @item_1 = create(:item, merchant: @merchants[0])
    @item_2 = create(:item, merchant: @merchants[1])
    @item_3 = create(:item, merchant: @merchants[2])

    @search_date = "2012-03-16"
    @invoice_1 = create(:invoice, merchant: @merchants[0], created_at: @search_date, customer: @customer)
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

  describe 'GET /api/v1/customers/:id/favorite_merchant' do
    it "returns a merchant where the customer has conducted the most successful transactions" do
      get "/api/v1/customers/#{@customer.id}/favorite_merchant"
      expect(response).to be_successful

      favorite_merchant = JSON.parse(response.body)["data"]["attributes"]

      expect(favorite_merchant["id"]).to eq(@merchants[0].id)
      expect(favorite_merchant["name"]).to eq(@merchants[0].name)
    end
  end
end

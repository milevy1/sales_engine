require 'rails_helper'

describe "Invoice Items API Relationship Endpoints" do
  before :each do
    @merchant_1 = create(:merchant)

    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)

    @invoice_1 = create(:invoice, merchant: @merchant_1)
    @invoice_2 = create(:invoice)

    @transaction_1 = create(:failed_transaction, invoice: @invoice_1)
    @transaction_2 = create(:transaction, invoice: @invoice_1)
    @unaffilated_transaction = create(:transaction)

    @invoice_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1)
    @invoice_item_2 = create(:invoice_item, invoice: @invoice_1, item: @item_2)
    @unaffilated_invoice_item = create(:invoice_item)
  end

  describe 'GET /api/v1/invoice_items/:id/invoice' do
    it 'returns the associated invoice' do
      get "/api/v1/invoice_items/#{@invoice_item_1.id}/invoice"
      expect(response).to be_successful

      invoice = JSON.parse(response.body)["data"]["attributes"]

      expect(invoice["id"]).to eq(@invoice_1.id)
      expect(invoice["customer_id"]).to eq(@invoice_1.customer_id)
    end
  end

  describe 'GET /api/v1/invoice_items/:id/item' do
    it 'returns the associated item' do
      get "/api/v1/invoice_items/#{@invoice_item_1.id}/item"
      expect(response).to be_successful

      item = JSON.parse(response.body)["data"]["attributes"]

      expect(item["id"]).to eq(@item_1.id)
      expect(item["name"]).to eq(@item_1.name)
    end
  end
end

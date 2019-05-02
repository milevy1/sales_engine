require 'rails_helper'

describe "Merchants API Relationship Endpoints" do
  before :each do
    @merchant_1 = create(:merchant)

    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)
    @unaffiliated_item = create(:item)

    @invoice_1 = create(:invoice, merchant: @merchant_1)
    @invoice_2 = create(:invoice, merchant: @merchant_1)
    @unaffiliated_invoice = create(:invoice)
  end

  describe 'GET /api/v1/merchants/:id/items' do
    it 'returns a collection of items associated with that merchant' do
      get "/api/v1/merchants/#{@merchant_1.id}/items"
      expect(response).to be_successful

      items = JSON.parse(response.body)["data"]

      expect(items.count).to eq(2)
      expect(items.first["attributes"]["id"]).to be_in([@item_1.id, @item_2.id])
      expect(items.last["attributes"]["id"]).to be_in([@item_1.id, @item_2.id])

      items.each do |item|
        expect(item["attributes"]["merchant_id"]).to eq(@merchant_1.id)
      end
    end
  end

  describe 'GET /api/v1/merchants/:id/invoices' do
    it 'returns a collection of invoices associated with that merchant from their known orders' do
      get "/api/v1/merchants/#{@merchant_1.id}/invoices"
      expect(response).to be_successful

      invoices = JSON.parse(response.body)["data"]

      expect(invoices.count).to eq(2)
      expect(invoices.first["attributes"]["id"]).to be_in([@invoice_1.id, @invoice_2.id])
      expect(invoices.last["attributes"]["id"]).to be_in([@invoice_1.id, @invoice_2.id])

      invoices.each do |item|
        expect(item["attributes"]["merchant_id"]).to eq(@merchant_1.id)
      end
    end
  end
end

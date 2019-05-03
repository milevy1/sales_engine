require 'rails_helper'

describe "Invoices API Relationship Endpoints" do
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

  describe 'GET /api/v1/invoices/:id/transactions' do
    it 'returns a collection of associated transactions' do
      get "/api/v1/invoices/#{@invoice_1.id}/transactions"
      expect(response).to be_successful

      transactions = JSON.parse(response.body)["data"]

      expect(transactions.count).to eq(2)

      transactions.each do |transaction|
        expect(transaction["attributes"]["invoice_id"]).to eq(@invoice_1.id)
      end
    end
  end

  describe 'GET /api/v1/invoices/:id/invoice_items' do
    it 'returns a collection of associated invoice items' do
      get "/api/v1/invoices/#{@invoice_1.id}/invoice_items"
      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)["data"]

      expect(invoice_items.count).to eq(2)

      invoice_items.each do |invoice_item|
        expect(invoice_item["attributes"]["invoice_id"]).to eq(@invoice_1.id)
      end
    end
  end

  describe 'GET /api/v1/invoices/:id/items' do
    it 'returns a collection of associated items' do
      get "/api/v1/invoices/#{@invoice_1.id}/items"
      expect(response).to be_successful

      items = JSON.parse(response.body)["data"]

      expect(items.count).to eq(2)

      items.each do |item|
        expect(item["attributes"]["merchant_id"]).to eq(@invoice_1.merchant_id)
      end
    end
  end

  describe 'GET /api/v1/invoices/:id/customer' do
    it 'returns the associated customer' do
      get "/api/v1/invoices/#{@invoice_1.id}/customer"
      expect(response).to be_successful

      customer = JSON.parse(response.body)["data"]["attributes"]

      expect(customer["id"]).to eq(@invoice_1.customer.id)
      expect(customer["first_name"]).to eq(@invoice_1.customer.first_name)
      expect(customer["last_name"]).to eq(@invoice_1.customer.last_name)
    end
  end

  describe 'GET /api/v1/invoices/:id/merchant' do
    it 'returns the associated merchant' do
      get "/api/v1/invoices/#{@invoice_1.id}/merchant"

      merchant = JSON.parse(response.body)["data"]["attributes"]

      expect(merchant["id"]).to eq(@invoice_1.merchant.id)
      expect(merchant["name"]).to eq(@invoice_1.merchant.name)
    end
  end
end

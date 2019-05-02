require 'rails_helper'

describe "Invoices API Relationship Endpoints" do
  before :each do
    @invoice_1 = create(:invoice)
    @invoice_2 = create(:invoice)

    @transaction_1 = create(:failed_transaction, invoice: @invoice_1)
    @transaction_2 = create(:transaction, invoice: @invoice_1)
    @unaffilated_transaction = create(:transaction)

    @invoice_item_1 = create(:invoice_item, invoice: @invoice_1)
    @invoice_item_2 = create(:invoice_item, invoice: @invoice_1)
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
end

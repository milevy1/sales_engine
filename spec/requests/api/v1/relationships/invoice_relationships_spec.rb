require 'rails_helper'

describe "Invoices API Relationship Endpoints" do
  before :each do
    @invoice_1 = create(:invoice)
    @invoice_2 = create(:invoice)

    @transaction_1 = create(:failed_transaction, invoice: @invoice_1)
    @transaction_2 = create(:transaction, invoice: @invoice_1)
    @unaffilated_transaction = create(:transaction)
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
end

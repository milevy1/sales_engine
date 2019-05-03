require 'rails_helper'

describe "Transactions API Relationship Endpoints" do
  before :each do
    @transaction_1 = create(:transaction)
  end

  describe 'GET /api/v1/transactions/:id/invoice' do
    it 'returns the associated invoice' do
      get "/api/v1/transactions/#{@transaction_1.id}/invoice"
      expect(response).to be_successful

      invoice = JSON.parse(response.body)["data"]["attributes"]

      expect(invoice["id"]).to eq(@transaction_1.invoice_id)
      expect(invoice["customer_id"]).to eq(@transaction_1.invoice.customer_id)
      expect(invoice["merchant_id"]).to eq(@transaction_1.invoice.merchant_id)
    end
  end
end

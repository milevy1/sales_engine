require 'rails_helper'

describe "Customers API Relationship Endpoints" do
  before :each do
    @customer_1 = create(:customer)

    @invoice_1 = create(:invoice, customer: @customer_1)
    @invoice_2 = create(:invoice, customer: @customer_1)
    @unaffiliated_invoice = create(:invoice)

    @transaction_1 = create(:transaction, invoice: @invoice_1)
    @transaction_2 = create(:transaction, invoice: @invoice_2)
    @unaffiliated_transaction = create(:transaction)
  end

  describe 'GET /api/v1/customers/:id/invoices' do
    it 'returns a collection of associated invoices' do
      get "/api/v1/customers/#{@customer_1.id}/invoices"
      expect(response).to be_successful

      invoices = JSON.parse(response.body)["data"]

      expect(invoices.count).to eq(2)

      invoices.each do |invoice|
        expect(invoice["attributes"]["customer_id"]).to eq(@customer_1.id)
      end
    end
  end

  describe 'GET /api/v1/customers/:id/transactions' do
    it 'returns a collection of associated transactions' do
      get "/api/v1/customers/#{@customer_1.id}/transactions"
      expect(response).to be_successful

      transactions = JSON.parse(response.body)["data"]

      expect(transactions.count).to eq(2)

      transactions.each do |transaction|
        expect(transaction["attributes"]["id"]).to be_in [@transaction_1.id, @transaction_2.id]
        expect(transaction["attributes"]["credit_card_number"]).to be_in [@transaction_1.credit_card_number, @transaction_2.credit_card_number]
      end
    end
  end
end

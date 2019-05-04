require 'rails_helper'

describe 'Merchants API Business Intelligence Endpoints' do
  before :each do
    @merchants = create_list(:merchant, 3)
    @favorite_customer = create(:customer)

    @item_1 = create(:item, merchant: @merchants[0])
    @item_2 = create(:item, merchant: @merchants[1])
    @item_3 = create(:item, merchant: @merchants[2])

    @search_date = "2012-03-16"
    @invoice_1 = create(:invoice, merchant: @merchants[0], created_at: @search_date, customer: @favorite_customer)
    @invoice_2 = create(:invoice, merchant: @merchants[1], created_at: @search_date)
    @invoice_3 = create(:invoice, merchant: @merchants[2], customer: @favorite_customer)

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

  describe 'GET /api/v1/merchants/most_revenue?quantity=x' do
    it "returns the top x merchants ranked by total revenue" do
      quantity = 2

      get "/api/v1/merchants/most_revenue?quantity=#{quantity}"
      expect(response).to be_successful

      top_2_merchants = JSON.parse(response.body)["data"]

      expect(top_2_merchants.count).to eq(quantity)
      expect(top_2_merchants[0]["id"].to_i).to eq(@merchants[0].id)
      expect(top_2_merchants[1]["id"].to_i).to eq(@merchants[1].id)
    end
  end

  describe 'GET /api/v1/merchants/most_items?quantity=x' do
    it 'returns the top x merchants ranked by total number of items sold' do
      quantity = 2

      get "/api/v1/merchants/most_items?quantity=#{quantity}"
      expect(response).to be_successful

      top_2_merchants = JSON.parse(response.body)["data"]

      expect(top_2_merchants.count).to eq(quantity)
      expect(top_2_merchants[0]["id"].to_i).to eq(@merchants[0].id)
      expect(top_2_merchants[1]["id"].to_i).to eq(@merchants[1].id)
    end
  end

  describe 'GET /api/v1/merchants/revenue?date=x' do
    it 'returns the total revenue for date x across all merchants' do
      get "/api/v1/merchants/revenue?date=#{@search_date}"
      expect(response).to be_successful

      data = JSON.parse(response.body)["data"]["attributes"]

      expected_revenue = @invoice_item_1.quantity * @invoice_item_1.unit_price + @invoice_item_2.quantity * @invoice_item_2.unit_price
      expected_revenue_to_dollars_string = (BigDecimal(expected_revenue) / 100).to_s

      expect(data).to eq({"total_revenue" => expected_revenue_to_dollars_string})
    end
  end

  describe 'GET /api/v1/merchants/:id/revenue' do
    it 'returns the total revenue for that merchant across successful transactions' do
      get "/api/v1/merchants/#{@merchants[0].id}/revenue"
      expect(response).to be_successful

      data = JSON.parse(response.body)["data"]["attributes"]

      expected_revenue = @invoice_item_1.quantity * @invoice_item_1.unit_price
      expected_revenue_to_dollars_string = (BigDecimal(expected_revenue) / 100).to_s

      expect(data).to eq({"revenue" => expected_revenue_to_dollars_string})
    end
  end

  describe 'GET /api/v1/merchants/:id/revenue?date=x' do
    it 'returns the total revenue for that merchant for a specific invoice date x' do
      get "/api/v1/merchants/#{@merchants[0].id}/revenue?date=#{@search_date}"
      expect(response).to be_successful

      data = JSON.parse(response.body)["data"]["attributes"]

      expected_revenue = @invoice_item_1.quantity * @invoice_item_1.unit_price
      expected_revenue_to_dollars_string = (BigDecimal(expected_revenue) / 100).to_s

      expect(data).to eq({"revenue" => expected_revenue_to_dollars_string})
    end
  end

  describe 'GET /api/v1/merchants/:id/favorite_customer' do
    it 'returns the customer who has conducted the most total number of successful transactions' do
      get "/api/v1/merchants/#{@merchants[0].id}/favorite_customer"
      expect(response).to be_successful

      data = JSON.parse(response.body)["data"]["attributes"]

      expect(data["id"]).to eq(@favorite_customer.id)
    end
  end

  describe 'GET /api/v1/merchants/:id/customers_with_pending_invoices' do
    it 'returns a collection of customers which have pending (unpaid) invoices' do
      get "/api/v1/merchants/#{@merchants[2].id}/customers_with_pending_invoices"

      data = JSON.parse(response.body)["data"]

      expect(data.size).to eq(1)
      expect(data[0]["attributes"]["id"]).to eq(@favorite_customer.id)
      expect(data[0]["attributes"]["first_name"]).to eq(@favorite_customer.first_name)
    end
  end
end

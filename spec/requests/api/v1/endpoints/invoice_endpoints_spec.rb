require 'rails_helper'

describe "Invoices API Endpoints" do
  before :each do
    @timestamp = "2012-03-27T14:54:05.000Z"
    @invoice_1 = create(:invoice,
      created_at: @timestamp,
      updated_at: @timestamp
    )
    @invoice_2 = create(:invoice)

    @expected = {
                "data" => {
                  "id" => "#{@invoice_1.id}",
                    "type" => "invoice",
                    "attributes" => {
                      "id" => @invoice_1.id,
                      "customer_id" => @invoice_1.customer_id,
                      "merchant_id" => @invoice_1.merchant_id,
                      "status" => @invoice_1.status
                    }
                  }
                }
  end

  it "sends a list of invoices" do
    get '/api/v1/invoices.json'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expected = {
                "data" => [
                {
                  "id" => "#{@invoice_1.id}",
                    "type" => "invoice",
                    "attributes" => {
                      "id" => @invoice_1.id,
                      "customer_id" => @invoice_1.customer_id,
                      "merchant_id" => @invoice_1.merchant_id,
                      "status" => @invoice_1.status
                    }
                },
                {
                  "id" => "#{@invoice_2.id}",
                  "type" => "invoice",
                  "attributes" => {
                    "id" => @invoice_2.id,
                    "customer_id" => @invoice_2.customer_id,
                    "merchant_id" => @invoice_2.merchant_id,
                    "status" => @invoice_2.status
                  }
                }
               ]
              }

    expect(invoices).to eq(expected)
  end

  it 'sends a single invoice' do
    get "/api/v1/invoices/#{@invoice_1.id}.json"

    expect(response).to be_successful

    data = JSON.parse(response.body)

    expect(data).to eq(@expected)
  end

  it 'can find a single row by parameters' do
    # Find by id
    get "/api/v1/invoices/find?id=#{@invoice_1.id}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(@expected)

    # Find by customer_id
    get "/api/v1/invoices/find?customer_id=#{@invoice_1.customer_id}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(@expected)

    # Find by merchant_id
    get "/api/v1/invoices/find?merchant_id=#{@invoice_1.merchant_id}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(@expected)

    # Find by status
    get "/api/v1/invoices/find?status=#{@invoice_1.status}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(@expected)

    # Find by created_at
    get "/api/v1/invoices/find?created_at=#{@timestamp}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(@expected)

    # Find by updated_at
    get "/api/v1/invoices/find?updated_at=#{@timestamp}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(@expected)
  end

  it 'can find_all rows by parameters' do
    expected = {
      "data" => [
        {
          "id" => "#{@invoice_1.id}",
          "type" => "invoice",
          "attributes" => {
            "id" => @invoice_1.id,
            "customer_id" => @invoice_1.customer_id,
            "merchant_id" => @invoice_1.merchant_id,
            "status" => @invoice_1.status
          }
        }
      ]
    }

    # Find all with .id
    get "/api/v1/invoices/find_all?id=#{@invoice_1.id}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find all with .customer_id
    get "/api/v1/invoices/find_all?customer_id=#{@invoice_1.customer_id}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find all with .merchant_id
    get "/api/v1/invoices/find_all?merchant_id=#{@invoice_1.merchant_id}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find all with .created_at
    get "/api/v1/invoices/find_all?created_at=#{@timestamp}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find all with .updated_at
    get "/api/v1/invoices/find_all?updated_at=#{@timestamp}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)
  end

  it 'can find a random invoice' do
    get "/api/v1/invoices/random.json"

    expect(response).to be_successful

    data = JSON.parse(response.body)

    expect(data["data"].class).to eq(Hash)
    expect(data["data"]["type"]).to eq("invoice")
  end
end

require 'rails_helper'

describe "InvoiceItem API Endpoints" do
  before :each do
    @timestamp = "2012-03-27T14:54:05.000Z"
    @invoice_item_1 = create(:invoice_item,
      created_at: @timestamp,
      updated_at: @timestamp
    )
    @invoice_item_2 = create(:invoice_item)

    @expected = {
                "data" => {
                  "id" => "#{@invoice_item_1.id}",
                    "type" => "invoice_item",
                    "attributes" => {
                      "id" => @invoice_item_1.id,
                      "item_id" => @invoice_item_1.item_id,
                      "invoice_id" => @invoice_item_1.invoice_id,
                      "quantity" => @invoice_item_1.quantity,
                      "unit_price" => @invoice_item_1.unit_price_to_dollar_string
                    }
                  }
                }
  end

  it "sends a list of invoice_items" do
    get '/api/v1/invoice_items.json'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expected = {
                "data" => [
                {
                  "id" => "#{@invoice_item_1.id}",
                    "type" => "invoice_item",
                    "attributes" => {
                      "id" => @invoice_item_1.id,
                      "item_id" => @invoice_item_1.item_id,
                      "invoice_id" => @invoice_item_1.invoice_id,
                      "quantity" => @invoice_item_1.quantity,
                      "unit_price" => @invoice_item_1.unit_price_to_dollar_string
                    }
                },
                {
                  "id" => "#{@invoice_item_2.id}",
                  "type" => "invoice_item",
                  "attributes" => {
                    "id" => @invoice_item_2.id,
                    "item_id" => @invoice_item_2.item_id,
                    "invoice_id" => @invoice_item_2.invoice_id,
                    "quantity" => @invoice_item_2.quantity,
                    "unit_price" => @invoice_item_2.unit_price_to_dollar_string
                  }
                }
               ]
              }

    expect(invoices).to eq(expected)
  end

  it 'sends a single invoice' do
    get "/api/v1/invoice_items/#{@invoice_item_1.id}.json"

    expect(response).to be_successful

    data = JSON.parse(response.body)

    expect(data).to eq(@expected)
  end

  it 'can find a single row by parameters' do
    # Find by id
    get "/api/v1/invoice_items/find?id=#{@invoice_item_1.id}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(@expected)

    # Find by item_id
    get "/api/v1/invoice_items/find?item_id=#{@invoice_item_1.item_id}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(@expected)

    # Find by invoice_id
    get "/api/v1/invoice_items/find?invoice_id=#{@invoice_item_1.invoice_id}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(@expected)

    # Find by quantity
    get "/api/v1/invoice_items/find?quantity=#{@invoice_item_1.quantity}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(@expected)

    # Find by unit_price
    get "/api/v1/invoice_items/find?unit_price=#{@invoice_item_1.unit_price_to_dollar_string}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(@expected)

    # Find by created_at
    get "/api/v1/invoice_items/find?created_at=#{@timestamp}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(@expected)

    # Find by updated_at
    get "/api/v1/invoice_items/find?updated_at=#{@timestamp}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(@expected)
  end

  it 'can find_all rows by parameters' do
    expected = {
      "data" => [
        {
          "id" => "#{@invoice_item_1.id}",
          "type" => "invoice_item",
          "attributes" => {
            "id" => @invoice_item_1.id,
            "item_id" => @invoice_item_1.item_id,
            "invoice_id" => @invoice_item_1.invoice_id,
            "quantity" => @invoice_item_1.quantity,
            "unit_price" => @invoice_item_1.unit_price_to_dollar_string
          }
        }
      ]
    }

    # Find all with .id
    get "/api/v1/invoice_items/find_all?id=#{@invoice_item_1.id}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find all with .item_id
    get "/api/v1/invoice_items/find_all?item_id=#{@invoice_item_1.item_id}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find all with .invoice_id
    get "/api/v1/invoice_items/find_all?invoice_id=#{@invoice_item_1.invoice_id}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find all with .quantity
    get "/api/v1/invoice_items/find_all?quantity=#{@invoice_item_1.quantity}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find all with .unit_price
    get "/api/v1/invoice_items/find_all?unit_price=#{@invoice_item_1.unit_price_to_dollar_string}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find all with .created_at
    get "/api/v1/invoice_items/find_all?created_at=#{@timestamp}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find all with .updated_at
    get "/api/v1/invoice_items/find_all?updated_at=#{@timestamp}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)
  end

  it 'can find a random invoice' do
    get "/api/v1/invoice_items/random.json"

    expect(response).to be_successful

    data = JSON.parse(response.body)

    expect(data["data"].class).to eq(Hash)
    expect(data["data"]["type"]).to eq("invoice_item")
  end
end

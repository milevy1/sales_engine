require 'rails_helper'

describe "Items API Endpoints" do
  before :each do
    @timestamp = "2012-03-27T14:54:05.000Z"
    @item_1 = create(:item,
      created_at: @timestamp,
      updated_at: @timestamp
    )
    @item_2 = create(:item)

    @expected = {
                "data" => {
                  "id" => "#{@item_1.id}",
                    "type" => "item",
                    "attributes" => {
                      "id" => @item_1.id,
                      "name" => @item_1.name,
                      "description" => @item_1.description,
                      "unit_price" => @item_1.unit_price_to_dollar_string,
                      "merchant_id" => @item_1.merchant_id
                    }
                  }
                }
  end

  it "sends a list of items" do
    get '/api/v1/items.json'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expected = {
                "data" => [
                {
                  "id" => "#{@item_1.id}",
                    "type" => "item",
                    "attributes" => {
                      "id" => @item_1.id,
                      "name" => @item_1.name,
                      "description" => @item_1.description,
                      "unit_price" => @item_1.unit_price_to_dollar_string,
                      "merchant_id" => @item_1.merchant_id
                    }
                },
                {
                  "id" => "#{@item_2.id}",
                  "type" => "item",
                  "attributes" => {
                    "id" => @item_2.id,
                    "name" => @item_2.name,
                    "description" => @item_2.description,
                    "unit_price" => @item_2.unit_price_to_dollar_string,
                    "merchant_id" => @item_2.merchant_id
                  }
                }
               ]
              }

    expect(items).to eq(expected)
  end

  it 'sends a single item' do
    get "/api/v1/items/#{@item_1.id}.json"

    expect(response).to be_successful

    data = JSON.parse(response.body)

    expect(data).to eq(@expected)
  end

  it 'can find a single row by parameters' do
    # Find by id
    get "/api/v1/items/find?id=#{@item_1.id}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(@expected)

    # Find by name
    get "/api/v1/items/find?name=#{@item_1.name}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(@expected)

    # Find by merchant_id
    get "/api/v1/items/find?merchant_id=#{@item_1.merchant_id}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(@expected)

    # Find by description
    get "/api/v1/items/find?description=#{@item_1.description}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(@expected)

    # Find by unit_price
    get "/api/v1/items/find?unit_price=#{@item_1.unit_price_to_dollar_string}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(@expected)

    # Find by created_at
    get "/api/v1/items/find?created_at=#{@timestamp}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(@expected)

    # Find by updated_at
    get "/api/v1/items/find?updated_at=#{@timestamp}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(@expected)
  end

  it 'can find_all rows by parameters' do
    expected = {
      "data" => [
        {
          "id" => "#{@item_1.id}",
          "type" => "item",
          "attributes" => {
            "id" => @item_1.id,
            "name" => @item_1.name,
            "description" => @item_1.description,
            "unit_price" => @item_1.unit_price_to_dollar_string,
            "merchant_id" => @item_1.merchant_id
          }
        }
      ]
    }

    # Find all with .id
    get "/api/v1/items/find_all?id=#{@item_1.id}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find all with .name
    get "/api/v1/items/find_all?name=#{@item_1.name}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find all with .description
    get "/api/v1/items/find_all?description=#{@item_1.description}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find all with .unit_price
    get "/api/v1/items/find_all?unit_price=#{@item_1.unit_price_to_dollar_string}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find all with .merchant_id
    get "/api/v1/items/find_all?merchant_id=#{@item_1.merchant_id}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find all with .created_at
    get "/api/v1/items/find_all?created_at=#{@timestamp}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find all with .updated_at
    get "/api/v1/items/find_all?updated_at=#{@timestamp}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)
  end

  it 'can find a random item' do
    get "/api/v1/items/random.json"

    expect(response).to be_successful

    data = JSON.parse(response.body)

    expect(data["data"].class).to eq(Hash)
    expect(data["data"]["type"]).to eq("item")
  end
end

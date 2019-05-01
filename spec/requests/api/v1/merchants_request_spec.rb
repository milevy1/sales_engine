require 'rails_helper'

describe "Merchants API" do
  before :each do
    @timestamp = "2012-03-27T14:54:05.000Z"
    @merchant_1 = create(:merchant,
      created_at: @timestamp,
      updated_at: @timestamp
    )
    @merchant_2 = create(:merchant)
  end

  it "sends a list of merchants" do
    get '/api/v1/merchants.json'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expected = {
                "data" => [
                {
                  "id" => "#{@merchant_1.id}",
                    "type" => "merchant",
                    "attributes" => {
                      "id" => @merchant_1.id,
                      "name" => "#{@merchant_1.name}"
                    }
                },
                {
                  "id" => "#{@merchant_2.id}",
                  "type" => "merchant",
                  "attributes" => {
                    "id" => @merchant_2.id,
                    "name" => "#{@merchant_2.name}"
                  }
                }
               ]
              }

    expect(merchants).to eq(expected)
  end

  it 'sends a single merchant' do
    get "/api/v1/merchants/#{@merchant_1.id}.json"

    expect(response).to be_successful

    data = JSON.parse(response.body)

    expected = {
                "data" => {
                  "id" => "#{@merchant_1.id}",
                    "type" => "merchant",
                    "attributes" => {
                      "id" => @merchant_1.id,
                      "name" => "#{@merchant_1.name}"
                    }
                  }
                }

    expect(data).to eq(expected)
  end

  it 'can find a single row by parameters' do
    expected = {
      "data" => {
        "id" => "#{@merchant_1.id}",
        "type" => "merchant",
        "attributes" => {
          "id" => @merchant_1.id,
          "name" => "#{@merchant_1.name}"
        }
      }
    }

    # Find by name
    get "/api/v1/merchants/find?name=#{@merchant_1.name}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find by id
    get "/api/v1/merchants/find?id=#{@merchant_1.id}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find by created_at
    get "/api/v1/merchants/find?created_at=#{@timestamp}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find by updated_at
    get "/api/v1/merchants/find?updated_at=#{@timestamp}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)
  end

  it 'can find_all rows by parameters' do
    expected = {
      "data" => [
        {
          "id" => "#{@merchant_1.id}",
          "type" => "merchant",
          "attributes" => {
            "id" => @merchant_1.id,
            "name" => "#{@merchant_1.name}"
          }
        }
      ]
    }

    # Find all with .name
    get "/api/v1/merchants/find_all?name=#{@merchant_1.name}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find all with .id
    get "/api/v1/merchants/find_all?id=#{@merchant_1.id}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find all with .created_at
    get "/api/v1/merchants/find_all?created_at=#{@timestamp}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find all with .updated_at
    get "/api/v1/merchants/find_all?updated_at=#{@timestamp}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)
  end

  it 'can find a random merchant' do
    get "/api/v1/merchants/random.json"

    expect(response).to be_successful

    data = JSON.parse(response.body)

    expect(data["data"].class).to eq(Hash)
    expect(data["data"]["type"]).to eq("merchant")
  end
end

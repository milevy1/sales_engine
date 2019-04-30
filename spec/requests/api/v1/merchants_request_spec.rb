require 'rails_helper'

describe "Merchants API" do
  before :each do
    @merchant_1 = create(:merchant)
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
                      "name" => "#{@merchant_1.name}"
                    }
                },
                {
                  "id" => "#{@merchant_2.id}",
                  "type" => "merchant",
                  "attributes" => {
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
                      "name" => "#{@merchant_1.name}"
                    }
                  }
                }

    expect(data).to eq(expected)
  end

  it 'can find by parameters' do
    get "/api/v1/merchants/find?name=#{@merchant_1.name}"

    expect(response).to be_successful

    data = JSON.parse(response.body)

    expected = {
                "data" => {
                  "id" => "#{@merchant_1.id}",
                    "type" => "merchant",
                    "attributes" => {
                      "name" => "#{@merchant_1.name}"
                    }
                  }
                }

    expect(data).to eq(expected)

    get "/api/v1/merchants/find?id=#{@merchant_1.id}"

    data = JSON.parse(response.body)

    expect(data).to eq(expected)
  end
end

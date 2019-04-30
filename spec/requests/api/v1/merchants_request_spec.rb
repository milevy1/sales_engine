require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)

    get '/api/v1/merchants.json'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expected = {
                "data" => [
                {
                  "id" => "#{merchant_1.id}",
                    "type" => "merchant",
                    "attributes" => {
                      "name" => "#{merchant_1.name}",
                    }
                },
                {
                  "id" => "#{merchant_2.id}",
                  "type" => "merchant",
                  "attributes" => {
                    "name" => "#{merchant_2.name}",
                  }
                }
               ]
              }

    expect(merchants).to eq(expected)
  end
end

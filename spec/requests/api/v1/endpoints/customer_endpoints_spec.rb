require 'rails_helper'

describe "Customer API Endpoints" do
  before :each do
    @timestamp = "2012-03-27T14:54:05.000Z"
    @customer_1 = create(:customer,
      created_at: @timestamp,
      updated_at: @timestamp
    )
    @customer_2 = create(:customer)
  end

  it "sends a list of customers" do
    get '/api/v1/customers.json'

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expected = {
                "data" => [
                {
                  "id" => "#{@customer_1.id}",
                    "type" => "customer",
                    "attributes" => {
                      "id" => @customer_1.id,
                      "first_name" => "#{@customer_1.first_name}",
                      "last_name" => "#{@customer_1.last_name}"
                    }
                },
                {
                  "id" => "#{@customer_2.id}",
                  "type" => "customer",
                  "attributes" => {
                    "id" => @customer_2.id,
                    "first_name" => "#{@customer_2.first_name}",
                    "last_name" => "#{@customer_2.last_name}"
                  }
                }
               ]
              }

    expect(customers).to eq(expected)
  end

  it 'sends a single customer' do
    get "/api/v1/customers/#{@customer_1.id}.json"

    expect(response).to be_successful

    data = JSON.parse(response.body)

    expected = {
                "data" => {
                  "id" => "#{@customer_1.id}",
                    "type" => "customer",
                    "attributes" => {
                      "id" => @customer_1.id,
                      "first_name" => "#{@customer_1.first_name}",
                      "last_name" => "#{@customer_1.last_name}"
                    }
                  }
                }

    expect(data).to eq(expected)
  end

  it 'can find a single row by parameters' do
    expected = {
                "data" => {
                  "id" => "#{@customer_1.id}",
                    "type" => "customer",
                    "attributes" => {
                      "id" => @customer_1.id,
                      "first_name" => "#{@customer_1.first_name}",
                      "last_name" => "#{@customer_1.last_name}"
                    }
                  }
                }


    # Find by id
    get "/api/v1/customers/find?id=#{@customer_1.id}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find by first_name
    get "/api/v1/customers/find?first_name=#{@customer_1.first_name}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find by last_name
    get "/api/v1/customers/find?last_name=#{@customer_1.last_name}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find by created_at
    get "/api/v1/customers/find?created_at=#{@timestamp}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find by updated_at
    get "/api/v1/customers/find?updated_at=#{@timestamp}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)
  end

  it 'can find_all rows by parameters' do
    expected = {
                "data" => [{
                  "id" => "#{@customer_1.id}",
                    "type" => "customer",
                    "attributes" => {
                      "id" => @customer_1.id,
                      "first_name" => "#{@customer_1.first_name}",
                      "last_name" => "#{@customer_1.last_name}"
                    }
                  }]
                }

    # Find all with .id
    get "/api/v1/customers/find_all?id=#{@customer_1.id}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find all with .first_name
    get "/api/v1/customers/find_all?first_name=#{@customer_1.first_name}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find all with .last_name
    get "/api/v1/customers/find_all?last_name=#{@customer_1.last_name}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find all with .created_at
    get "/api/v1/customers/find_all?created_at=#{@timestamp}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find all with .updated_at
    get "/api/v1/customers/find_all?updated_at=#{@timestamp}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)
  end

  it 'can find a random customer' do
    get "/api/v1/customers/random.json"

    expect(response).to be_successful

    data = JSON.parse(response.body)

    expect(data["data"].class).to eq(Hash)
    expect(data["data"]["type"]).to eq("customer")
  end
end

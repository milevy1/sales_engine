require 'rails_helper'

describe "Transactions API Endpoints" do
  before :each do
    @timestamp = "2012-03-27T14:54:05.000Z"
    @transaction_1 = create(:transaction,
      created_at: @timestamp,
      updated_at: @timestamp
    )
    @failed_transaction = create(:failed_transaction)

    @expected = {
                "data" => {
                  "id" => "#{@transaction_1.id}",
                    "type" => "transaction",
                    "attributes" => {
                      "id" => @transaction_1.id,
                      "invoice_id" => @transaction_1.invoice_id,
                      "credit_card_number" => @transaction_1.credit_card_number,
                      "result" => @transaction_1.result
                    }
                  }
                }
  end

  it "sends a list of transactions" do
    get '/api/v1/transactions.json'

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expected = {
                "data" => [
                {
                  "id" => "#{@transaction_1.id}",
                    "type" => "transaction",
                    "attributes" => {
                      "id" => @transaction_1.id,
                      "invoice_id" => @transaction_1.invoice_id,
                      "credit_card_number" => @transaction_1.credit_card_number,
                      "result" => @transaction_1.result
                    }
                },
                {
                  "id" => "#{@failed_transaction.id}",
                  "type" => "transaction",
                  "attributes" => {
                    "id" => @failed_transaction.id,
                    "invoice_id" => @failed_transaction.invoice_id,
                    "credit_card_number" => @failed_transaction.credit_card_number,
                    "result" => @failed_transaction.result
                  }
                }
               ]
              }

    expect(transactions).to eq(expected)
  end

  it 'sends a single transaction' do
    get "/api/v1/transactions/#{@transaction_1.id}.json"

    expect(response).to be_successful

    data = JSON.parse(response.body)

    expect(data).to eq(@expected)
  end

  it 'can find a single row by parameters' do
    # Find by id
    get "/api/v1/transactions/find?id=#{@transaction_1.id}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(@expected)

    # Find by invoice_id
    get "/api/v1/transactions/find?invoice_id=#{@transaction_1.invoice_id}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(@expected)

    # Find by credit_card_number
    get "/api/v1/transactions/find?credit_card_number=#{@transaction_1.credit_card_number}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(@expected)

    # Find by result
    get "/api/v1/transactions/find?result=#{@transaction_1.result}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(@expected)

    # Find by created_at
    get "/api/v1/transactions/find?created_at=#{@timestamp}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(@expected)

    # Find by updated_at
    get "/api/v1/transactions/find?updated_at=#{@timestamp}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(@expected)
  end

  it 'can find_all rows by parameters' do
    expected = {
      "data" => [
        {
          "id" => "#{@transaction_1.id}",
          "type" => "transaction",
          "attributes" => {
            "id" => @transaction_1.id,
            "invoice_id" => @transaction_1.invoice_id,
            "credit_card_number" => @transaction_1.credit_card_number,
            "result" => @transaction_1.result
          }
        }
      ]
    }

    # Find all with .id
    get "/api/v1/transactions/find_all?id=#{@transaction_1.id}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find all with .invoice_id
    get "/api/v1/transactions/find_all?invoice_id=#{@transaction_1.invoice_id}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find all with .credit_card_number
    get "/api/v1/transactions/find_all?credit_card_number=#{@transaction_1.credit_card_number}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find all with .result
    get "/api/v1/transactions/find_all?result=#{@transaction_1.result}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find all with .created_at
    get "/api/v1/transactions/find_all?created_at=#{@timestamp}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)

    # Find all with .updated_at
    get "/api/v1/transactions/find_all?updated_at=#{@timestamp}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to eq(expected)
  end

  it 'can find a random transaction' do
    get "/api/v1/transactions/random.json"

    expect(response).to be_successful

    data = JSON.parse(response.body)

    expect(data["data"].class).to eq(Hash)
    expect(data["data"]["type"]).to eq("transaction")
  end
end

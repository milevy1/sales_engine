require 'rails_helper'

describe "Items API Relationship Endpoints" do
  before :each do
    @item_1 = create(:item)
    @item_2 = create(:item)

    @invoice_item_1 = create(:invoice_item, item: @item_1)
    @invoice_item_2 = create(:invoice_item, item: @item_1)
  end

  describe 'GET /api/v1/items/:id/invoice_items' do
    it 'returns a collection of associated invoice items' do
      get "/api/v1/items/#{@item_1.id}/invoice_items"
      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)["data"]

      expect(invoice_items.count).to eq(2)

      invoice_items.each do |invoice_item|
        expect(invoice_item["attributes"]["item_id"]).to eq(@item_1.id)
      end
    end
  end
end

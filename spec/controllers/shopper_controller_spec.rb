require 'rails_helper'

RSpec.describe ShopperController, type: :controller do

  describe "POST #create" do
    it "returns 201" do
      post :create, attributes_for(:shopper)
      expect(response).to have_http_status(:created)
    end

    it "returns 400 when invalid attrs" do
      post :create, {}
      expect(response).to have_http_status(:bad_request)
    end
  end

end

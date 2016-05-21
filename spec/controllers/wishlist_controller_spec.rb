require 'rails_helper'

RSpec.describe WishlistController, type: :controller do

  describe "POST #create_or_update" do

    let(:shopper) { create :shopper }

    let(:items) { [ { name: "Playstation 4" } ] }

    context "when new list" do
      let(:post_create) do 
        @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(shopper.email, "some_password")
        post :create_or_update, { items: items }
      end

      it "creates a new list" do
        expect {
          post_create
        }.to change(Wishlist, :count).by(1)
      end

      it "creates a new list with items" do
        expect {
          post_create
        }.to change(Item, :count).by(1)
      end

      it "returns 201" do
        post_create
        expect(response).to have_http_status(:created)
      end
    end

    context "when a list already exists" do

      before do
        shopper.build_wishlist(items: items.map { |i| Item.new(i) })
        shopper.save
      end

      let(:new_items) { [ { name: "Xbox One" } ] }

      let(:post_update) do
        @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(shopper.email, "some_password")
        post :create_or_update, { items: new_items }
      end

      it "doesn't create a new list" do
        expect { post_update }.to_not change(Wishlist, :count)
      end

      it "changes existing list" do
        post_update
        expect(shopper.reload.wishlist.items.map { |i| { name: i.name} }).to eq(new_items)
      end
    end
  end


end

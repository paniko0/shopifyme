require 'rails_helper'

RSpec.describe Shopper, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password_hash }

  it { should have_one :wishlist }

  it "sets password_hash when creating a Shopper with password" do
    shopper = described_class.create(attributes_for(:shopper))
    expect(shopper.password_hash).to_not be_nil
  end

  describe ".authenticate" do

    let(:shopper) do
      create :shopper
    end

    it "returns an existing user" do
      expect(described_class.authenticate(shopper.email, "some_password")).to_not be_nil
    end

    it "returns nil when invalid password" do
      expect(described_class.authenticate(shopper.email, "invalid")).to be_nil
    end

    it "returns nil when invalid email" do
      expect(described_class.authenticate("invalid", "some_password")).to be_nil
    end
  end
end

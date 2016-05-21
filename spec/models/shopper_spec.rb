require 'rails_helper'

RSpec.describe Shopper, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password_hash }

  it "sets password_hash when creating a Shopper with password" do
    shopper = described_class.create(attributes_for(:shopper))
    expect(shopper.password_hash).to_not be_nil
  end
end

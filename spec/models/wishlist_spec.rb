require 'rails_helper'

RSpec.describe Wishlist, type: :model do
  it { should belong_to :shopper }
  it { should have_many :items }

  it { should validate_presence_of :shopper }
end

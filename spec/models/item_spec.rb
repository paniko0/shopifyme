require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :wishlist }
  it { should belong_to :wishlist }
end

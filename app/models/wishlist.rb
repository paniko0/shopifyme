class Wishlist < ActiveRecord::Base
  belongs_to :shopper

  has_many :items

  validates :shopper, presence: true
end

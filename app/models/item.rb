class Item < ActiveRecord::Base
  validates :name, presence: true
  validates :wishlist, presence: true

  belongs_to :wishlist
end

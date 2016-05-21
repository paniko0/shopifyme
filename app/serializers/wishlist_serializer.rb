class WishlistSerializer < ActiveModel::Serializer
  has_many :items
end

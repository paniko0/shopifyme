class OfferSerializer < ActiveModel::Serializer
  attributes :product, :price, :store

  def price
    (object.price * 100).to_i
  end
end

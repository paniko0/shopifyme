class OfferSerializer < ActiveModel::Serializer
  attributes :product, :price, :store, :wish

  def wish
    object.product
  end

  def price
    (object.price * 100).to_i
  end
end

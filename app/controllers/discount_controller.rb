class DiscountController < ApplicationController
  def discount
    shopify_api

    amount = params["product_amount"].to_f
    new_amount = amount - (amount * 0.10)

    product = ShopifyAPI::Product.find(params["product_id"])
    product.variants.last.price = new_amount
    product.save!

    save_offer(product.title, "store", new_amount)
    #send_push_notifications

    redirect_to "/products"

  end

  private

  def save_offer(title, store, amount)
    items = Item.basic_search(name: title)

    items.each do |i|
      Offer.create(shopper: i.wishlist.shopper, product: title, price: amount, store: current_user.uid)
    end
  end

  def send_push_notifications
    headers = { "Authorization" => "key=AIzaSyC1KMLqu1xL5njIqEpBNGyzlE4VLQAMIqA", "Content-Type" => "application/json" }
    body = {
      registration_ids: [ "ids" ]
    }
    resp = HTTParty.post "https://fcm.googleapis.com/fcm/send", headers: headers, body: body.to_json
    logger.info "Request to fcm sent: resp=#{resp}"
  rescue => e
    logger.info "Error has happened: #{e.message}"
  end
end

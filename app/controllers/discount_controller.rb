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
      o = Offer.create(shopper: i.wishlist.shopper, product: title, price: amount, store: current_user.uid)

      if i.wishlist.shopper.token
        send_push_notification(o, i.wishlist.shopper.token)
      end
    end
  end

  def send_push_notification(offer, token)
    headers = { "Authorization" => "key=AIzaSyC1KMLqu1xL5njIqEpBNGyzlE4VLQAMIqA", "Content-Type" => "application/json" }
    body = {
      data: {
        new_offer: "new"
      },
      to: token
    }
    resp = HTTParty.post "https://fcm.googleapis.com/fcm/send", headers: headers, body: body.to_json
    logger.info "request to fcm sent: resp=#{resp}"
  rescue => e
    logger.info "Error has happened: #{e.message}"
  end
end

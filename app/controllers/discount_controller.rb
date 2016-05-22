class DiscountController < ApplicationController
  def discount
    shopify_api

    amount = params["product_amount"].to_f

    product = ShopifyAPI::Product.find(params["product_id"])
    product.variants.last.price = amount - (amount * 0.10)
    product.save!

    send_push_notifications

    redirect_to "/products"

  end

  private
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

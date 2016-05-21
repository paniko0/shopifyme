class DiscountController < ApplicationController
  def discount
    shopify_api

    amount = params["product_amount"].to_f
    
    product = ShopifyAPI::Product.find(params["product_id"])
    product.variants.last.price = amount - (amount * 0.10)
    product.save!

    redirect_to "/products"

  end
end

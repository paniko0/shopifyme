class ProductsController < ApplicationController
  def list
    shopify_api
    @products = ShopifyAPI::Product.all
  end
end

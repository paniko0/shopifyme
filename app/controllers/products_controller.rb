class ProductsController < ApplicationController
  def list
    shopify_api
    @products = ShopifyAPI::Product.all.map do |p|
      Product.new(id: p.id, title: p.title, price: p.variants[0].price, img: p.images.first.src, interested: calculate_interest(p.title))
    end
  end

  private
  def calculate_interest(name)
    Item.basic_search(name: name).size
  end
end

class Product
  attr_accessor :id, :title, :price, :img, :interested

  def initialize(params)
    @id = params[:id]
    @title = params[:title]
    @price = params[:price]
    @img = params[:img]
    @interested = params[:interested]
  end
end

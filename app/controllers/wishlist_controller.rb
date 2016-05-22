class WishlistController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  before_action :authenticate

  def index
    current_shopper.build_wishlist unless current_shopper.wishlist
    current_shopper.save
    render json: current_shopper.wishlist
  end

  def create_or_update
    current_shopper.build_wishlist unless current_shopper.wishlist
    current_shopper.wishlist.items.delete_all
    items_params["items"].each do |i|
      current_shopper.wishlist.items << Item.new(i)
    end
    current_shopper.save
    render json: current_shopper.wishlist, status: 201
  end

  private
  def items_params
    params.permit(items: [ :name ])
  end

  def authenticate
    authenticate_or_request_with_http_basic do |u, p|
      @shopper = Shopper.authenticate(u, p)
    end
  end

  def current_shopper
    @shopper
  end

end

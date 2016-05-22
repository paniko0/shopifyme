class OfferController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  before_action :authenticate

  def index
    render json: current_shopper.offers, root: "items", adapter: :json
  end

  private
  def authenticate
    authenticate_or_request_with_http_basic do |u, p|
      @shopper = Shopper.authenticate(u, p)
    end
  end

  def current_shopper
    @shopper
  end
end

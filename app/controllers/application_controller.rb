class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    ShopifyUser.where(token: session[:user]).take!
  end

  def shopify_api
    puts "#{current_user.inspect}"
    @shopify_api_session = ShopifyAPI::Session.new(current_user.uid, current_user.token)
    ShopifyAPI::Base.activate_session(@shopify_api_session)
  end
end

class OauthController < ApplicationController

  def callback
    user = ShopifyUser.where(uid: auth_hash.uid).first_or_initialize
    user.update_attributes(token: auth_hash.credentials.token)

    session[:user] = user.token
    
    redirect_to "/products"

  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end

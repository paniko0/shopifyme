class OauthController < ApplicationController

  def callback
    @user = ShopifyUser.create(token: auth_hash.credentials.token, uid: auth_hash.uid)
    current_user = @user
    redirect_to "/products"
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end

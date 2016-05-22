class ShopperController < ActionController::API
  def create
    shopper = Shopper.new(shopper_params)
    if shopper.valid?
      shopper.save
      render nothing: true, status: 201 and return
    end

    render nothing: true, status: 400
  end

  private
  def shopper_params
    params.permit(:email, :password, :token)
  end
end

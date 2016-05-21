class ConditionalMiddleware

  def initialize(app, &block)
    @app = app
    @omniauth = OmniAuth::Builder.new(app, &block)
  end

  def call(env)
    if env['PATH_INFO'].starts_with? '/api'
      @app.call(env)
    else
      @omniauth.call(env)
    end
  end
end

Rails.application.config.middleware.use ConditionalMiddleware do
  provider :shopify, "3c27a6baf6112b449967ee0e90cc7865", "31d0751ffb884b74591faf4a261fc1a9", :scope => 'read_products,write_products'
end

#Rails.application.config.middleware.use OmniAuth::Builder do
#  provider :shopify, "3c27a6baf6112b449967ee0e90cc7865", "31d0751ffb884b74591faf4a261fc1a9", :scope => 'read_products,write_products'
#end

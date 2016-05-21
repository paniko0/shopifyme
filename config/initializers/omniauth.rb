Rails.application.config.middleware.use OmniAuth::Builder do
  provider :shopify, "3c27a6baf6112b449967ee0e90cc7865", "31d0751ffb884b74591faf4a261fc1a9", :scope => 'read_products,write_products'
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :shopify, "74e9ee24cf26519b7297f77fff2b9ac3", "8b5b5ccb9fe186ff98c0ead1d318a45a", :scope => 'read_products,write_products'
end

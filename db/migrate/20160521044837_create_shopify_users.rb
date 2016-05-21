class CreateShopifyUsers < ActiveRecord::Migration
  def change
    create_table :shopify_users do |t|
      t.string :uid
      t.string :token

      t.timestamps null: false
    end
  end
end

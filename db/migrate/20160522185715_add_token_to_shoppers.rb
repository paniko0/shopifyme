class AddTokenToShoppers < ActiveRecord::Migration
  def change
    add_column :shoppers, :token, :string
  end
end

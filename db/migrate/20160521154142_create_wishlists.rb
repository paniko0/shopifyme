class CreateWishlists < ActiveRecord::Migration
  def change
    create_table :wishlists do |t|
      t.integer :shopper_id

      t.timestamps null: false
    end
  end
end

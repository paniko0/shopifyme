class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.integer :shopper_id
      t.string :product
      t.float :price

      t.timestamps null: false
    end
  end
end

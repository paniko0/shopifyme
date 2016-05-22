class AddStoreToOffer < ActiveRecord::Migration
  def change
    add_column :offers, :store, :string
  end
end

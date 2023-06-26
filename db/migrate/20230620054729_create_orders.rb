class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity
      t.float :total_price
      t.text :shipping_address
      t.text :billing_address
      t.string :pincode
      t.string :phone_number


      t.timestamps
    end
  end
end

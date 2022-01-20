class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|

      t.integer :customer_id, null: false
      t.integer :payment_method, null: false, default: 0
      t.string :post_code,     null: false
      t.string :address,       null: false
      t.string :owner, null: false
      t.integer :shipping_fee, null: false
      t.integer :charge, null: false
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end

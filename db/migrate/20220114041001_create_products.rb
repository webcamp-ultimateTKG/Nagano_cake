class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|


      t.integer :genre_id, null: false
      t.string :image_id
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :price, null: false
      t.boolean :is_active, null: false, default: true


      t.timestamps
    end
    add_foreign_key :products, :genres
  end
end

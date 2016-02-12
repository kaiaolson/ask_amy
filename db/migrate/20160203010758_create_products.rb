class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.text :description
      t.integer :sale_price

      t.timestamps null: false
    end
  end
end

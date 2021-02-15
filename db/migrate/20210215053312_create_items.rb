class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :item_name
      t.text :description
      t.integer :category_id
      t.integer :condition_id
      t.integer :allocation_id
      t.integer :from_id
      t.integer :to_ship_id
      t.integer :price
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end

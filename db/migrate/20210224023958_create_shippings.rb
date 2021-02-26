class CreateShippings < ActiveRecord::Migration[6.0]
  def change
    create_table :shippings do |t|
      t.string :zip,                   null: false
      t.integer :from_id,              null: false
      t.string :delivery_municipality, null: false
      t.string :delivery_street,       null: false
      t.string :delivery_building
      t.string :tel,                   null: false
      t.references :purchase,          null: false, foreign_key: true
      t.timestamps
    end
  end
end

class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.references :brand, null: false, foreign_key: true
      t.string :name
      t.date :expiry_date
      t.integer :used
      t.decimal :price
      t.text :description
      t.boolean :sold, null: false, default: false

      t.timestamps
    end
  end
end

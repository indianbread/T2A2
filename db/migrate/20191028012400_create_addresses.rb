class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :street_number
      t.string :suburb
      t.integer :postcode
      t.string :state
      t.string :country
      t.string :type

      t.timestamps
    end
  end
end

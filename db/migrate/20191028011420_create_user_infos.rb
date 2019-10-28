class CreateUserInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :user_infos do |t|
      t.references :user, null: false, foreign_key: true
      t.string :first_name
      t.string :surname
      t.integer :gender
      t.boolean :admin, null: false, default: false 

      t.timestamps
    end
  end
end

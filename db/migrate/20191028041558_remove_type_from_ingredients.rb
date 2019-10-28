class RemoveTypeFromIngredients < ActiveRecord::Migration[6.0]
  def change

    remove_column :ingredients, :type, :string
  end
end

class RemoveTypeFromBrand < ActiveRecord::Migration[6.0]
  def change

    remove_column :brands, :type, :string
  end
end

class RemoveAdminFromUserInfo < ActiveRecord::Migration[6.0]
  def change

    remove_column :user_infos, :admin, :boolean
  end
end

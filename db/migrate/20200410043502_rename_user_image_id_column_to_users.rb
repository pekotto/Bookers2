class RenameUserImageIdColumnToUsers < ActiveRecord::Migration[5.2]
  def change
  	rename_column :users, :user_image_id, :profile_image_id
  end
end

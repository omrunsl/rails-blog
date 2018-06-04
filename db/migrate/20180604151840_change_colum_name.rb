class ChangeColumName < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :usernae, :username
  end
end

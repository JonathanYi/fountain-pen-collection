class AddUseridColumnInks < ActiveRecord::Migration[5.1]
  def change
    add_column :inks, :user_id, :integer
  end
end

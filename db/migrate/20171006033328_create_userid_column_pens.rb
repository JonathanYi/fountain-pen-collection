class CreateUseridColumnPens < ActiveRecord::Migration[5.1]
  def change
    add_column :pens, :user_id, :integer
  end
end

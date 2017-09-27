class CreatePens < ActiveRecord::Migration[5.1]
  def change
    create_table :pens do |t|
      t.string :name
      t.string :brand
      t.integer :collection_id
      t.integer :ink_id
    end
  end
end

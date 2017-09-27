class CreateInks < ActiveRecord::Migration[5.1]
  def change
    create_table :inks do |t|
      t.string :name
      t.string :brand
    end
  end
end

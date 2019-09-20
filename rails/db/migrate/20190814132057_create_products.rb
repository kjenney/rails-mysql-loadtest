class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :count
      t.text :description
      t.references :supplier, foreign_key: true

      t.timestamps
    end
    add_index :products, :name
  end
end

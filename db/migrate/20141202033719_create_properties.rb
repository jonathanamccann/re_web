class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.references :organization, index: true
      t.string :title
      t.text :description

      t.timestamps null: false
    end
    add_foreign_key :properties, :organizations
  end
end

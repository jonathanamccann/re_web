class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.references :organization, index: true
      t.text :name

      t.timestamps null: false
    end
  end
end

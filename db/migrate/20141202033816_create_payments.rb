class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :property, index: true
      t.integer :amount

      t.timestamps null: false
    end
    add_foreign_key :payments, :properties
  end
end

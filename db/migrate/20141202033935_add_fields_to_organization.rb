class AddFieldsToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :phone, :string
    add_column :organizations, :state, :string
    add_column :organizations, :street_address, :string
    add_column :organizations, :zip, :string
    add_column :organizations, :email, :string
    add_column :organizations, :is_enabled, :string
  end
end

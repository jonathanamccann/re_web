class CreateOrganizationAppSettings < ActiveRecord::Migration
  def change
    create_table :organization_app_settings do |t|
      t.references :organization, index: true
      t.string :default_from_email

      t.timestamps null: false
    end
    add_foreign_key :organization_app_settings, :organizations
  end
end

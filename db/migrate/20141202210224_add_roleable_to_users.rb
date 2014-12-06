class AddRoleableToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :roleable, polymorphic: true, index: true
  end
end

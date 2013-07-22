class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.belongs_to :role
      t.belongs_to :user

      t.timestamps
    end

    add_index :authorizations, :role_id
    add_index :authorizations, :user_id
  end
end

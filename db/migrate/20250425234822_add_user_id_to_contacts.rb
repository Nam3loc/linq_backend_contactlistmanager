class AddUserIdToContacts < ActiveRecord::Migration[8.0]
  def change
    add_column :contacts, :user_id, :integer
  end
end

class RemoveNotesFromContacts < ActiveRecord::Migration[8.0]
  def change
    remove_column :contacts, :notes, :string
  end
end

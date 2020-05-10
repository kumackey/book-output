class RemoveUserIdFromBooks < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :books, :users
    remove_index :books, :user_id
    remove_reference :books, :user
  end
end

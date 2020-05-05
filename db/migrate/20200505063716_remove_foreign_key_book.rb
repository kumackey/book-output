class RemoveForeignKeyBook < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :books, :users
    remove_index :books, :user_id

    remove_foreign_key :likes, :books
    remove_index :likes, :book_id

    remove_foreign_key :questions, :books
    remove_index :questions, :book_id
  end
end

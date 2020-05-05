class ChangeTypeOfBookId < ActiveRecord::Migration[5.2]
  def change
    change_column :likes, :book_id, :string
    change_column :questions, :book_id, :string
  end
end

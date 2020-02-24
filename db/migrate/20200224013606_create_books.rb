class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.integer :isbn, null: false
      t.string :title, null: false
      t.string :author, null: false
      t.string :image
      t.text :detail
      t.references :user, foreign_key: true
      t.datetime :published_at

      t.timestamps
    end

    add_index :books, :isbn, unique: true
    add_index :books, :title
    add_index :books, :author
  end
end

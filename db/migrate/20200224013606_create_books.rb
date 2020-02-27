class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.bigint :isbn, null: false
      t.string :title, null: false
      t.string :author, null: false
      t.string :image
      t.text :detail
      t.references :user, index: true, foreign_key: true
      t.date :published_at

      t.timestamps
    end

    add_index :books, :isbn, unique: true
    add_index :books, [:user_id, :created_at, :author, :title]
  end
end

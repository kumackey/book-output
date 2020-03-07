class CreateChoices < ActiveRecord::Migration[5.2]
  def change
    create_table :choices do |t|
      t.references :output, foreign_key: true
      t.string :content, null: false
      t.boolean :is_answer
      # nullならば、一意性制約に引っかからない! よってnullを入れる
      t.timestamps
      t.index [:output_id, :is_answer], unique: true
    end
  end
end

class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answer_descriptions do |t|
      t.references :question, foreign_key: true
      t.text :content, null: false
      
      t.timestamps
    end
  end
end
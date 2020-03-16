class ChangeOutputsToQuestions < ActiveRecord::Migration[5.2]
  def change
    rename_table :outputs, :questions
    add_reference :choices, :question, index: true
    add_index :choices, [:question_id, :is_answer]
  end
end

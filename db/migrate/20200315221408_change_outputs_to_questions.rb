class ChangeOutputsToQuestions < ActiveRecord::Migration[5.2]
  def change
    rename_table :outputs, :questions
  end
end

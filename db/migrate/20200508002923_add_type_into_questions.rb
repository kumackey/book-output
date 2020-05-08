class AddTypeIntoQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :answer_type, :integer, null: false
  end
end

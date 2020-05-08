class AddTypeIntoQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :type, :integer, null: false
  end
end

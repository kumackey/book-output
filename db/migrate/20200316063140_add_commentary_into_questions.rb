class AddCommentaryIntoQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :commentary, :text
  end
end

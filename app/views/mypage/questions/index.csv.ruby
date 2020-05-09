require 'csv'

CSV.generate do |csv|
  column_names = %w[本のタイトル 問題文 解説文 正答 誤答1 誤答2 誤答3]
  csv << column_names
  @questions.each do |question|
    if question.answer_type == 'choices'
      answer = question.choices.find_by(is_answer: true).content
      incorrect_choice1 = question.choices.where(is_answer: nil)[0].content
      incorrect_choice2 = question.choices.where(is_answer: nil)[1]&.content
      incorrect_choice3 = question.choices.where(is_answer: nil)[2]&.content
    elsif question.answer_type == 'only_answer'
      answer = question.answer.content
    end
    column_values = [
      question.book.title,
      question.content,
      question.commentary,
      answer,
      incorrect_choice1,
      incorrect_choice2,
      incorrect_choice3
    ]
    csv << column_values
  end
end

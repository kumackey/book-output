book = Book.find_by(googlebooksapi_id: "ROFLDwAAQBAJ") # カイゼン・ジャーニー

puts "Start inserting seed #{book.title} ..."

user = User.find(2)
guest_user = User.find_by(email: 'guest@guest.jp')

register_output_form = RegisterOutputForm.new(
  question_content: "タスクボードに関する記述として、合っているものはどれか？",
  correct_choice: 'TODOは溢れやすいので、Parking Lotという別の場所にためておく',
  incorrect_choice_1: 'DOINGには2つ程度のタスクを置く',
  incorrect_choice_2: '最終的にDOINGに移動させれば、そのタスクは完了となる',
  incorrect_choice_3: 'Parking Lotにも優先順位を付ける',
  user_id: user.id,
  book_id: book.id
)
register_output_form.save_question_and_choices
puts "#{register_output_form.question_content} has created!"

register_output_form = RegisterOutputForm.new(
  question_content: "グッドサイクルにするためには、どの質に注目することからスタートすべきか？",
  commentary: '関係の質→思考の質→行動の質→結果の質となっているため',
  correct_choice: '関係の質',
  incorrect_choice_1: '思考の質',
  incorrect_choice_2: '行動の質',
  incorrect_choice_3: '結果の質',
  user_id: user.id,
  book_id: book.id
)
register_output_form.save_question_and_choices
puts "#{register_output_form.question_content} has created!"

register_output_form = RegisterOutputForm.new(
  question_content: "パーキンソンの法則を説明したものはどれか？",
  correct_choice: '一度期間が設定されてしまうと、その中で対処するように考えてしまう',
  incorrect_choice_1: 'バッファを設けて計画を行うと、計画通りにリリースが行われやすい',
  incorrect_choice_2: '開発側でしか発生しない問題である',
  user_id: guest_user.id,
  book_id: book.id
)
register_output_form.save_question_and_choices
puts "#{register_output_form.question_content} has created!"

register_output_form = RegisterOutputForm.new(
  question_content: "ジョブ理論では、顧客の問題を解決する「手段」に注目している",
  correct_choice: '×',
  incorrect_choice_1: '○',
  user_id: guest_user.id,
  book_id: book.id
)
register_output_form.save_question_and_choices
puts "#{register_output_form.question_content} has created!"

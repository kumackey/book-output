book = Book.find_by(googlebooksapi_id: "ROFLDwAAQBAJ") # カイゼン・ジャーニー

puts "Start inserting seed #{book.title} ..."

user = User.find(2)
guest_user = User.find_by(email: 'guest@guest.jp')

output = user.outputs.create(
  content: "タスクボードに関する記述として、合っているものはどれか？",
  book_id: book.id
)
output.choices.create(
  content: 'TODOは溢れやすいので、Parking Lotという別の場所にためておく',
  is_answer: true
)
output.choices.create(
  content: 'DOINGには2つ程度のタスクを置く'
)
output.choices.create(
  content: '最終的にDOINGに移動させれば、そのタスクは完了となる'
)
output.choices.create(
  content: 'Parking Lotにも優先順位を付ける'
)
puts "quiz#{output.id} has created!"

output = user.outputs.create(
  content: "グッドサイクルにするためには、どの質に注目することからスタートすべきか？",
  book_id: book.id
)
output.choices.create(
  content: '関係の質',
  is_answer: true
)
output.choices.create(
  content: '思考の質'
)
output.choices.create(
  content: '行動の質'
)
output.choices.create(
  content: '結果の質'
)
puts "quiz#{output.id} has created!"

output = guest_user.outputs.create(
  content: "パーキンソンの法則を説明したものはどれか？",
  book_id: book.id
)
output.choices.create(
  content: '一度期間が設定されてしまうと、その中で対処するように考えてしまう',
  is_answer: true
)
output.choices.create(
  content: 'バッファを設けて計画を行うと、計画通りにリリースが行われやすい'
)
output.choices.create(
  content: '開発側でしか発生しない問題である'
)
puts "quiz#{output.id} has created!"

output = guest_user.outputs.create(
  content: "ジョブ理論では、顧客の問題を解決する「手段」に注目している",
  book_id: book.id
)
output.choices.create(
  content: '×',
  is_answer: true
)
output.choices.create(
  content: '○'
)
puts "quiz#{output.id} has created!"
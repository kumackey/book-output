book = Book.find_by(googlebooksapi_id: "xU6wDwAAQBAJ") # ヤバい集中力

puts "Start inserting seed #{book.title} ..."

user = User.find(3)
guest_user = User.find_by(email: 'guest@guest.jp')

output = user.outputs.create(
  content: "脳に良い食事MINDで推奨されている食事は？",
  book_id: book.id
)
output.choices.create(
  content: 'ナッツ類',
  is_answer: true
)
output.choices.create(
  content: 'チーズ'
)
output.choices.create(
  content: 'ワイン'
)
output.choices.create(
  content: '赤肉'
)
puts "quiz#{output.id} has created!"

output = user.outputs.create(
  content: "意志力に関する次の記述のうち、集中力をあげるものはどれか？",
  book_id: book.id
)
output.choices.create(
  content: 'やるべきタスクの種類によって、作業エリアを分ける',
  is_answer: true
)
output.choices.create(
  content: 'スマホが気になるくらいなら、一度見てしまう'
)
output.choices.create(
  content: '3〜4時間に一度は血糖値をキープするために何かを食べる'
)
output.choices.create(
  content: '外向的な人は、作業中に歌詞のついた曲を聞くようにする'
)
puts "quiz#{output.id} has created!"

output = guest_user.outputs.create(
  content: "報酬の予感として役に立たないものはどれか？",
  book_id: book.id
)
output.choices.create(
  content: 'タスク達成の難易度を難しくする',
  is_answer: true
)
output.choices.create(
  content: '与えられる報酬を小刻みにし、何度も与えられるようにする'
)
output.choices.create(
  content: 'あと少しで達成できた、というニアミスを頻繁に発生させる'
)
puts "quiz#{output.id} has created!"

output = guest_user.outputs.create(
  content: "「獣」の特性として誤っているものはどれか？",
  book_id: book.id
)
output.choices.create(
  content: 'エネルギー消費量が多い',
  is_answer: true
)
output.choices.create(
  content: 'パワーが強くコントロールが難しい'
)
output.choices.create(
  content: '難しいものを嫌う'
)
output.choices.create(
  content: 'あらゆる刺激に反応する'
)
puts "quiz#{output.id} has created!"
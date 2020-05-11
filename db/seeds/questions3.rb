book = Book.find_by(googlebooksapi_id: "xU6wDwAAQBAJ") # ヤバい集中力

puts "Start inserting seed #{book.title} ..."

user = User.find(3)
guest_user = User.find_by(email: 'guest@guest.jp')

create_quiz_choice_form = CreateQuizChoiceForm.new(
  question_content: "脳に良い食事MINDで推奨されている食事は？",
  correct_choice: 'ナッツ類',
  incorrect_choice_1: 'チーズ',
  incorrect_choice_2: 'ワイン',
  incorrect_choice_3: '赤肉',
  user_id: user.id,
  book_id: book.id
)
create_quiz_choice_form.save
puts "#{create_quiz_choice_form.question_content} has created!"

create_quiz_choice_form = CreateQuizChoiceForm.new(
  question_content: "意志力に関する次の記述のうち、集中力をあげるものはどれか？",
  correct_choice: 'やるべきタスクの種類によって、作業エリアを分ける',
  incorrect_choice_1: 'スマホが気になるくらいなら、一度見てしまう',
  incorrect_choice_2: '3〜4時間に一度は血糖値をキープするために何かを食べる',
  incorrect_choice_3: '外向的な人は、作業中に歌詞のついた曲を聞くようにする',
  user_id: user.id,
  book_id: book.id
)
create_quiz_choice_form.save
puts "#{create_quiz_choice_form.question_content} has created!"

create_quiz_choice_form = CreateQuizChoiceForm.new(
  question_content: "報酬の予感として役に立たないものはどれか？",
  correct_choice: 'タスク達成の難易度を難しくする',
  incorrect_choice_1: '与えられる報酬を小刻みにし、何度も与えられるようにする',
  incorrect_choice_2: 'あと少しで達成できた、というニアミスを頻繁に発生させる',
  user_id: guest_user.id,
  book_id: book.id
)
create_quiz_choice_form.save
puts "#{create_quiz_choice_form.question_content} has created!"

create_quiz_choice_form = CreateQuizChoiceForm.new(
  question_content: "「獣」の特性として誤っているものはどれか？",
  correct_choice: 'エネルギー消費量が多い',
  incorrect_choice_1: 'パワーが強くコントロールが難しい',
  incorrect_choice_2: '難しいものを嫌う',
  incorrect_choice_3: 'あらゆる刺激に反応する',
  user_id: guest_user.id,
  book_id: book.id
)
create_quiz_choice_form.save
puts "#{create_quiz_choice_form.question_content} has created!"

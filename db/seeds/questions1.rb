book = Book.find_by(googlebooksapi_id: "c4bnSAAACAAJ") # Webを支える技術

puts "Start inserting seed #{book.title} ..."

user = User.find(1)
guest_user = User.find_by(email: 'guest@guest.jp')

register_output_form = RegisterOutputForm.new(
  question_content: "HTTPのステータスコード201は何を示すか？",
  commentary: "リソースの恒久的な移動は301, アクセス権不正は401, リソースへのリクエストが成功は201",
  correct_choice: 'リソースの作成成功',
  incorrect_choice_1: 'リソースの恒久的な移動',
  incorrect_choice_2: 'アクセス権不正',
  incorrect_choice_3: 'リソースへのリクエストが成功',
  user_id: user.id,
  book_id: book.id
)
register_output_form.save
puts "#{register_output_form.question_content} has created!"

register_output_form = RegisterOutputForm.new(
  question_content: "SOAPはメッセージ転送方法だけを定めた仕様なので、実際のシステムを構築するにはSOAP上にサービスごとのプロトコルを定義する必要がある",
  correct_choice: '○',
  incorrect_choice_1: '×',
  user_id: user.id,
  book_id: book.id
)
register_output_form.save
puts "#{register_output_form.question_content} has created!"

register_output_form = RegisterOutputForm.new(
  question_content: "次のうち、アプリケーション層に含まれないプロトコルはどれか？",
  correct_choice: 'UDP',
  incorrect_choice_1: 'SSH',
  incorrect_choice_2: 'NTP',
  incorrect_choice_3: 'DNS',
  user_id: guest_user.id,
  book_id: book.id
)
register_output_form.save
puts "#{register_output_form.question_content} has created!"

register_output_form = RegisterOutputForm.new(
  question_content: "次のうち、冪等でないHTTPメソッドはどれか？",
  correct_choice: 'POST',
  incorrect_choice_1: 'PUT',
  incorrect_choice_2: 'DELETE',
  incorrect_choice_3: 'HEAD',
  user_id: guest_user.id,
  book_id: book.id
)
register_output_form.save
puts "#{register_output_form.question_content} has created!"

book = Book.find_by(googlebooksapi_id: "c4bnSAAACAAJ") # Webを支える技術

puts "Start inserting seed #{book.title} ..."

user = User.find(1)
guest_user = User.find_by(email: 'guest@guest.jp')

output = user.outputs.create(
  content: "HTTPのステータスコード201は何を示すか？",
  book_id: book.id
)
output.choices.create(
  content: 'リソースの作成成功',
  is_answer: true
)
output.choices.create(
  content: 'リソースの恒久的な移動'
)
output.choices.create(
  content: 'アクセス権不正'
)
output.choices.create(
  content: 'リソースへのリクエストが成功'
)
puts "quiz#{output.id} has created!"

output = user.outputs.create(
  content: "SOAPはメッセージ転送方法だけを定めた仕様なので、実際のシステムを構築するにはSOAP上にサービスごとのプロトコルを定義する必要がある",
  book_id: book.id
)
output.choices.create(
  content: '○',
  is_answer: true
)
output.choices.create(
  content: '×'
)
puts "quiz#{output.id} has created!"

output = guest_user.outputs.create(
  content: "次のうち、アプリケーション層に含まれないプロトコルはどれか？",
  book_id: book.id
)
output.choices.create(
  content: 'UDP',
  is_answer: true
)
output.choices.create(
  content: 'SSH'
)
output.choices.create(
  content: 'NTP'
)
output.choices.create(
  content: 'DNS'
)
puts "quiz#{output.id} has created!"

output = guest_user.outputs.create(
  content: "次のうち、冪等でないHTTPメソッドはどれか？",
  book_id: book.id
)
output.choices.create(
  content: 'POST',
  is_answer: true
)
output.choices.create(
  content: 'PUT'
)
output.choices.create(
  content: 'DELETE'
)
output.choices.create(
  content: 'HEAD'
)
puts "quiz#{output.id} has created!"
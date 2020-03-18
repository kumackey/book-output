puts 'Start inserting seed "books" ...'

googlebooksapi_ids = [
  "orl2tAEACAAJ", # プロを目指す人のためのRuby入門
  "WHfDDwAAQBAJ", # 科学的な適職
  "ROFLDwAAQBAJ", # カイゼン・ジャーニー たった1人からはじめて、「越境」するチームをつくるまで
  "4GqdwAEACAAJ", # FACTFULNESS(ファクトフルネス)
  "_bT8oAEACAAJ", # 影響力の武器
  "qNMHnwEACAAJ", # 嫌われる勇気
  "c4bnSAAACAAJ", # Webを支える技術
  "xU6wDwAAQBAJ", # ヤバい集中力 1日ブッ通しでアタマが冴えわたる神ライフハック45 
]

guest_user = User.find_by(email: 'guest@guest.jp')

googlebooksapi_ids.each do |id|
  google_book = GoogleBook.new_from_id(id)
  book = google_book.build_book_by_user(guest_user)
  book.save
  puts "\"#{book.title}\" has created! book.id: #{book.id}."
  guest_user.like(book)
end


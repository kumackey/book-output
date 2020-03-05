include GoogleBooksApi
puts 'Start inserting seed "books" ...'

googlebooksapi_ids = [
  "orl2tAEACAAJ", # プロを目指す人のためのRuby入門
  "WHfDDwAAQBAJ", # 科学的な適職
  "ROFLDwAAQBAJ", # カイゼン・ジャーニー たった1人からはじめて、「越境」するチームをつくるまで
  "4GqdwAEACAAJ", # FACTFULNESS(ファクトフルネス)
  "_bT8oAEACAAJ", # 影響力の武器
  "qNMHnwEACAAJ", # 嫌われる勇気
  "c4bnSAAACAAJ", # Webを支える技術
  "xU6wDwAAQBAJ", # #ヤバい集中力 1日ブッ通しでアタマが冴えわたる神ライフハック45 
]

guest_user = User.find_by(email: 'guest@guest.jp')

googlebooksapi_ids.each do |id|
  book = GoogleBook.new_from_id(id)
  seed_book = guest_user.books.build(
    author: book.author,
    description: book.description,
    googlebooksapi_id: book.googlebooksapi_id,
    published_at: book.published_at,
    title: book.title,
    buy_link: book.buy_link
  ) # DBの情報を持ちすぎてるので、本当ならモデルに移行したい
  seed_book.remote_image_url = book.image if book.image.present?
  seed_book.save
  puts "\"#{seed_book.title}\" has created! book.id: #{seed_book.id}."
end


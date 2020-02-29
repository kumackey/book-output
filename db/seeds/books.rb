puts 'Start inserting seed "books" ...'

isbn_array = [
  9784774193977, #プロを目指す人のためのRuby入門
  9788499924243, #ファスト&スロー(下)
  9784295403746, #科学的な適職
  9784799321133, #やり抜く人の９つの習慣
  9784797399967, #ヤバい集中力 1日ブッ通しでアタマが冴えわたる神ライフハック45
  9784798153346, #カイゼン・ジャーニー たった1人からはじめて、「越境」するチームをつくるまで
  9784822289607, #FACTFULNESS(ファクトフルネス)
  9784478025819, #嫌われる勇気
  9784414304220, #影響力の武器
  9784774142043, #Webを支える技術
]

guest_user = User.find_by(email: 'guest@guest.guest')
isbn_array.each do |isbn|
  json = JSON.parse(Net::HTTP.get(URI.parse(
    "https://www.googleapis.com/books/v1/volumes?q=isbn:#{isbn}"
  )))
  image_url = json["items"][0]["volumeInfo"]["imageLinks"]["smallThumbnail"]
  book = guest_user.books.create(
    author: json["items"][0]["volumeInfo"]["authors"][0],
    description: json["items"][0]["volumeInfo"]["description"],
    isbn: isbn,
    remote_image_url: image_url,
    googlebooksapi_id: json["items"][0]["id"],
    published_at: json["items"][0]["volumeInfo"]["publishedDate"],
    title: json["items"][0]["volumeInfo"]["title"],
    buyLink: json["items"][0]["saleInfo"]["buyLink"]
  )
  puts "\"#{book.title}\" has created!"
end


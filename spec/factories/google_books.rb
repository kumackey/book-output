FactoryBot.define do
  factory :google_book do
    googlebooksapi_id { 'wlNHDwAAQBAJ' }
    author { '太田 智彬' }
    authors do
      [
        '太田 智彬',
        '寺下 翔太',
        '手塚 亮',
        '宗像 亜由美',
        '株式会社リクルートテクノロジーズ'
      ]
    end
    description { '開発からリリースや運用まで、\u003cbr\u003e ベストプラクティスが一冊でわかる! \u003cp\u003e本書は、Ruby on Rails 5によるアプリケーションの\u003cbr\u003e 開発からリリース・運用まで、そのベストプラクティスが一冊でわかる本です。\u003c/p\u003e \u003cp\u003eRuby on Railsは効率的にアプリケーションを作ることができる\u003cbr\u003e フルスタックなMVCフレームワークですが、\u003cbr\u003e 同じ機能を実装するにもさまざまなやり方があり、初心者にとって、\u003cbr\u003e Web上の大量の情報の中からベストプラクティスを探し出すのは困難を極めます。\u003c/p\u003e \u003cp\u003e通常、このベストプラクティスのノウハウを得るにはある程度の経験が必要ですが、\u003cbr\u003e 本書を読むことで、使う機能・使わない機能を取捨選択し、効率よく学習することができます。\u003c/p\u003e \u003cp\u003eデファクトスタンダードとなっているライブラリ群の機能や使い方から、\u003cbr\u003e 開発時だけでなくリリースや運用時のベストプラクティスもカバーするので、\u003cbr\u003e 本書を読み込めば小規模〜中規模のサービス運用が一人である程度こなせるようになります。\u003c/p\u003e \u003cp\u003eサンプルをダウンロードできるので、自分でも試しながら学べます。\u003c/p\u003e \u003cp\u003e*Ruby言語およびMVCフレームワークの基礎を習得されている方を対象にしています\u003c/p\u003e \u003cp\u003e※本電子書籍は同名出版物を底本として作成しました。記載内容は印刷出版当時のものです。\u003cbr\u003e ※印刷出版再現のため電子書籍としては不要な情報を含んでいる場合があります。\u003cbr\u003e ※印刷出版とは異なる表記・表現の場合があります。予めご了承ください。\u003cbr\u003e ※プレビューにてお手持ちの電子端末での表示状態をご確認の上、商品をお買い求めください。\u003c/p\u003e \u003cp\u003e(翔泳社)\u003c/p\u003e' }
    image { 'http://books.google.com/books/content?id=wlNHDwAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&imgtk=AFLRE70j5lrdzOYN-iUu8w-G_JJKpEhnpUGAgqyZd7rj4jHu59NcAU48eQ75T4fkdyyZD6dMlwjjw0sAdQSKY_HiEdNBMMeyDn4DUmOcY-oLHFRAnxPXocc_T_PA7NYdSlZdwKckhCMy&source=gbs_api' }
    published_at { '2018-01-24' }
    publisher { '翔泳社' }
    title { 'Ruby on Rails 5の上手な使い方 現場のエンジニアが教えるRailsアプリケーション開発の実践手法' }
    buy_link { 'https://play.google.com/store/books/details?id=wlNHDwAAQBAJ&rdid=book-wlNHDwAAQBAJ&rdot=1&source=gbs_api' }
    web_reader_link { 'http://play.google.com/books/reader?id=wlNHDwAAQBAJ&hl=&printsec=frontcover&source=gbs_api' }
    page_count { 400 }
  end
end

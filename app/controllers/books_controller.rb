class BooksController < ApplicationController
  def new
    @url = "hogehoge"
  end

  def search_by_isbn
    json = JSON.parse(Net::HTTP.get(URI.parse(
      "https://api.openbd.jp/v1/get?isbn=#{params[:isbn]}"
    )))
    if json
      @book = current_user.books.build(
        author: json[0]["summary"]["author"],
        detail: json[0]["onix"]["DescriptiveDetail"]["TitleDetail"]["TitleElement"]["Subtitle"]["content"],
        image: "", #あとでcarrierwaveでの処理に変更する
        isbn: json[0]["summary"]["isbn"].to_i,
        published_at: json[0]["summary"]["pubdate"], # 例: "20190101"
        title: json[0]["summary"]["title"],
      )
      #@bookの値を渡す
    else
      #エラーを返す処理を作る
    end
  end
end

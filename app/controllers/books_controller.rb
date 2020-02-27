class BooksController < ApplicationController
  def new
    @book ||= Book.new
  end

  def search_by_isbn
    json = get_json_by_params
    @book = build_book_by(json) if json[0]
    @book ||= Book.new
    render :new
  end

  private

  def get_json_by_params
    JSON.parse(Net::HTTP.get(URI.parse(
      "https://api.openbd.jp/v1/get?isbn=#{book_params["isbn"]}"
    )))
  end

  def build_book_by(json)
    @book = current_user.books.build(
      author: json[0]["summary"]["author"],
      detail: json[0]["onix"]["DescriptiveDetail"]["TitleDetail"]["TitleElement"]["Subtitle"]["content"],
      image: "", #あとでcarrierwaveでの処理に変更する
      isbn: json[0]["summary"]["isbn"].to_i,
      published_at: json[0]["summary"]["pubdate"], # 例: "20190101"
      title: json[0]["summary"]["title"],
    )
  end

  def book_params
    params.require(:book).permit(:isbn)
  end
end
